//
//  HomeTableViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO: favourite mist to update

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

class HomeTableViewController: UITableViewController {
   
    let cellReuseIdentifier = "showTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear;
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "showTableCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HomeTableViewSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! ShowTableViewCell
        cell.bindingFrom(ShowTableViewModel(sectionType: HomeTableViewSection.sectionCase(from: indexPath)))
        cell.delegate = self
        return cell
    }
    
}

extension HomeTableViewController: ShowTableViewCellDelegate{
    
    func tableViewCell(_ tableViewCell: UITableViewCell, modelView: ShowTableViewModel, didSelectItemAt indexPath: IndexPath) {
        
        guard let detail = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailViewController")
                                                                        as? ShowDetailViewController else { return }
        let show = modelView.data[indexPath.row]
        let detailViewModel = ShowDetailViewModel(data: show)
        detail.viewModel = detailViewModel
        self.present(detail, animated: true,completion: nil)
        
    }
    
    
    
    
}
