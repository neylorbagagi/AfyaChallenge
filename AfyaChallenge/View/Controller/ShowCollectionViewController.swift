//
//  ShowCollectionViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit


class ShowCollectionViewController: UICollectionViewController, ShowCollectionViewDataDelegate {
    
    var collectionDataSource:ShowCollectionViewData?
    var collectionDelegate:ShowCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionDelegate = ShowCollectionViewDelegate()
        self.collectionView?.delegate = self.collectionDelegate
        
        self.collectionDataSource = ShowCollectionViewData(self.collectionView!)
        self.collectionView?.dataSource = self.collectionDataSource
        self.collectionDataSource?.delegate = self
        
        self.collectionView?.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ccllectionViewData(_ collectionView: UICollectionView, didDataUpdated data: [ACShow]) {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

}

