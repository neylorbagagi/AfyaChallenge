//
//  HomeTableViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tableDataSource:HomeTableViewData? = nil
    var tableViewDelegate:HomeTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(HighlightTableViewCell.self, forCellReuseIdentifier: "highlightTableCell")
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "showTableCell")
        
        self.tableDataSource = HomeTableViewData()
        self.tableView.dataSource = self.tableDataSource
        
        self.tableViewDelegate = HomeTableViewDelegate()
        self.tableView.delegate = self.tableViewDelegate
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
