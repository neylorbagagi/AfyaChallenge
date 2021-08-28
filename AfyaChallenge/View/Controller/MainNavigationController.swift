//
//  MainNavigationController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 20/08/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    var searchBar:UISearchBar?
    var searchButtom:UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buildSearchBar()
        self.buildSearchButton()
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()

    }
    
    @objc func toggleSearchBar() {
        self.searchBar?.isHidden.toggle()
        if self.navigationBar.topItem?.leftBarButtonItem == nil {
            self.navigationBar.topItem?.leftBarButtonItem = self.searchButtom
        } else {
            self.navigationBar.topItem?.leftBarButtonItem = nil
        }
        
    }
  
    func buildSearchBar(){
        self.searchBar = UISearchBar(frame: .zero)
        self.searchBar?.showsCancelButton = true
        self.navigationBar.topItem?.titleView = self.searchBar
        self.searchBar?.isHidden = true
    }
    
    func buildSearchButton(){
        self.searchButtom = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search,
                                            target: self,
                                            action: #selector(toggleSearchBar))
        
        self.searchButtom!.tintColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2352941176, alpha: 1) // UIColor(red: 55, green: 58, blue: 60, alpha: 1)
        self.navigationBar.topItem?.leftBarButtonItem = self.searchButtom
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
