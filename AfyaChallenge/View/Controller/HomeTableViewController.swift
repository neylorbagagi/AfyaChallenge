//
//  HomeTableViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController {
   
    var viewModel:HomeTableViewModel?
    
    var tableView:UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "showTableCell")
        tableView.separatorColor = .clear;
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.footerView(forSection: 16)
        return tableView
    }()
    
    var navigationBar:UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.isTranslucent = false
        return navigationBar
    }()
    
    var searchButton:UIBarButtonItem = {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: #selector(presentSearchViewController))
        searchButton.tintColor = #colorLiteral(red: 0.1369999945, green: 0.1369999945, blue: 0.1369999945, alpha: 1)
        return searchButton
    }()
    
    var imageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewModel = HomeTableViewModel()
        
        self.tableView.dataSource = self.viewModel
        
        let navigationItem = UINavigationItem()
        navigationItem.rightBarButtonItem = self.searchButton
        navigationItem.titleView = self.imageView
        
        self.navigationBar.setItems([navigationItem], animated: true)
        
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.navigationBar.heightAnchor.constraint(equalToConstant: 44),

            self.imageView.heightAnchor.constraint(equalToConstant: 34),
            
            self.tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func presentSearchViewController(){
        let resultsViewController = SearchViewController()
        resultsViewController.viewModel = SearchViewModel()
        self.present(resultsViewController, animated: true,completion: nil)
    }
}

extension HomeTableViewController: ShowTableViewCellDelegate{
    
    func tableViewCell(_ tableViewCell: UITableViewCell, modelView: ShowTableViewModel, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = ShowDetailViewController()
        let show = modelView.data[indexPath.row]
        let detailViewModel = ShowDetailViewModel(data: show)
        detailViewController.viewModel = detailViewModel
        self.present(detailViewController, animated: true,completion: nil)
    }
    
}
