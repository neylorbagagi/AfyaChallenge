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
    case Shows = 3
    case WatchNext = 1
    case Highlights = 0
    case New = 2
}

class HomeTableViewModel:NSObject, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case HomeTableViewSections.Highlights.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "highlightTableCell", for: indexPath)
                return cell
            case HomeTableViewSections.WatchNext.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "showTableCell", for: indexPath)
                return cell
            case HomeTableViewSections.New.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "showTableCell", for: indexPath)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "showTableCell", for: indexPath)
                return cell
        }

    }

    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch section {
             case HomeTableViewSections.Highlights.rawValue:
                return "Highlights"
             case HomeTableViewSections.WatchNext.rawValue:
                return "Watch Next"
             case HomeTableViewSections.New.rawValue:
                return "New"
             default:
                return "Shows"
         }
     }*/
    
    
}
