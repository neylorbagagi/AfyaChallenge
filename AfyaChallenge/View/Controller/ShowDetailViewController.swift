//
//  ShowDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    var viewModel:ShowDetailViewModel?
    var showDetailView:ShowDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showDetailView = self.view as? ShowDetailView
        self.showDetailView?.modelView = self.viewModel
        
        self.showDetailView?.reloadData()

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.showDetailView?.modelView?.stopRealmNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

