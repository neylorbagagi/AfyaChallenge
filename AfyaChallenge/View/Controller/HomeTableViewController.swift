//
//  HomeTableViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    private var tableViewModel:HomeTableViewModel?
    private let heightForSection:CGFloat = 41
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(HighlightTableViewCell.self, forCellReuseIdentifier: "highlightTableCell")
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "showTableCell")
        
        self.tableViewModel = HomeTableViewModel()
        self.tableView.dataSource = self.tableViewModel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.height - (self.heightForSection*3))/3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightForSection
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let labelFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.heightForSection)
        let label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "SFProText-Bold", size: 36)
        
        switch section {
        case HomeTableViewSections.Highlights.rawValue:
            label.text = "Highlights"
            return label
        case HomeTableViewSections.WatchNext.rawValue:
            label.text = "Watch Next"
            return label
        case HomeTableViewSections.New.rawValue:
            label.text = "New"
            return label
        default:
            label.text = "Shows"
            return label
        }
    }

}
