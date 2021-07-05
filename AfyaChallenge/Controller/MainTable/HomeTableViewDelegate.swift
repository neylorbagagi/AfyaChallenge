//
//  HomeTableViewDelegate.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 26/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

/// Family: SF Pro Text Font names: ["SFProText-LightItalic", "SFProText-Bold", "SFProText-Regular"]


class HomeTableViewDelegate:NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.height - (41*3))/3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let labelFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 41)
        let label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "SFProText-Bold", size: 36)
        
        switch section {
            case HomeTableViewSections.highlights.rawValue:
                label.text = "Highlights"
                return label
            case HomeTableViewSections.watchNext.rawValue:
                label.text = "Watch Next"
                return label
            case HomeTableViewSections.new.rawValue:
                label.text = "New"
                return label
            default:
                label.text = "Shows"
                return label
        }
    }
    
}
