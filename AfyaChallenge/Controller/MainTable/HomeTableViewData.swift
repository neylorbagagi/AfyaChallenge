//
//  HomeTableViewData.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit


public enum HomeTableViewSections:Int {
    case shows = 0
    case watchNext = 1
    case highlights = 2
    case new = 3
}

class HomeTableViewData:NSObject, UITableViewDataSource {
    
    private var dataCache:[ACShow] = []
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case HomeTableViewSections.highlights.rawValue:
            return "Highlights"
        case HomeTableViewSections.watchNext.rawValue:
            return "Watch Next"
        case HomeTableViewSections.new.rawValue:
            return "New"
        default:
            return "Shows"
        }
    }
    */
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case HomeTableViewSections.highlights.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "highlightTableCell", for: indexPath)
            return cell
        case HomeTableViewSections.watchNext.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "showTableCell", for: indexPath)
            return cell
        case HomeTableViewSections.new.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "showTableCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "showTableCell", for: indexPath)
            return cell
        }

    }

}
