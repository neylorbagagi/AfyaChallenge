//
//  HomeTableViewData.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

enum HomeTableViewSection:CaseIterable {
    case highlights, favourites, updates, rating
    
    static func sectionCase(from indexPath:IndexPath) -> HomeTableViewSection{
        switch indexPath.row {
            case 0:
                return .highlights
            case 1:
                return .favourites
            case 2:
                return .updates
            default:
                return .rating
        }
    }
}

class HomeTableViewModel:NSObject {
    
    var data:[HomeTableViewSection] {
        return HomeTableViewSection.allCases
    }
    
    func parentViewController(_ view:UIView) -> UIViewController? {
        var parentResponder: UIResponder? = view
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        
        return nil
    }
    
}

extension HomeTableViewModel:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let registeredCellClasses = tableView.value(forKey: "_cellClassDict") as? [String:Any],
              let cellReuseIdentifier = registeredCellClasses.first?.key else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ShowTableViewCell
        cell.bindingFrom(ShowTableViewModel(sectionType: HomeTableViewSection.sectionCase(from: indexPath)))
        cell.delegate = parentViewController(tableView) as! HomeTableViewController
        return cell
    }
    
    
}
