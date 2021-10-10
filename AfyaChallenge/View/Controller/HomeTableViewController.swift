//
//  HomeTableViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO: favourite mist to update



class HomeTableViewController: UITableViewController {
   
    var viewModel:HomeTableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = .clear;
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "showTableCell")
        
        self.viewModel = HomeTableViewModel()
        self.tableView.dataSource = self.viewModel
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension HomeTableViewController: ShowTableViewCellDelegate{
    
    func tableViewCell(_ tableViewCell: UITableViewCell, modelView: ShowTableViewModel, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = NewShowDetailViewController()
        let show = modelView.data[indexPath.row]
        let detailViewModel = NewShowDetailViewModel(data: show)
        detailViewController.viewModel = detailViewModel
        self.present(detailViewController, animated: true,completion: nil)
        
        
    }
    
}
