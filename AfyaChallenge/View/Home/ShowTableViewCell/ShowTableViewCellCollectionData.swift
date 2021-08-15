//
//  ShowTableViewCellCollectionData.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 27/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class ShowTableViewCellCollectionData:NSObject,UICollectionViewDataSource{
    
    private var dataCache:[Show] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    private var imageCache:[Int:UIImage] = [:]
    private var collectionView:UICollectionView?
    
    override init() {
        self.dataCache = []
        super.init()
        self.requestData(page: 0)
    }
    
    func requestData(page:Int){
//        APIClient.shared.getShows(forPage: page) { (data, error) in
//            guard error == nil else {
//                print(error.debugDescription)
//                return
//            }
//
//            self.dataCache = self.dataCache + data
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        
        if self.dataCache.count <= 10 {
            return self.dataCache.count
        } else {
            return 10
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCell", for: indexPath) as! ShowCollectionViewCell
        let show = self.dataCache[indexPath.row]
        
        // Configure the cell
        cell.poster.image = UIImage()
        
//        if let showImagePath = show.image?.medium {
//            if let imageUrl = URL(string: showImagePath){
//                DispatchQueue.global().async {
//                    if let imageData = try? Data(contentsOf: imageUrl){
//                        if let showPoster = UIImage(data: imageData){
//                            self.imageCache[show.id] = showPoster
//                            DispatchQueue.main.async {
//                                cell.poster.image = showPoster
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        // TODO: Put it on a func
//        if let showImagePath = show.image?.medium {
//
//            if let image = self.imageCache[show.id]{
//                cell.poster.image = image
//            } else{
//                if let imageUrl = URL(string: showImagePath){
//                    DispatchQueue.global().async {
//                        if let imageData = try? Data(contentsOf: imageUrl){
//                            if let showPoster = UIImage(data: imageData){
//                                self.imageCache[show.id] = showPoster
//                                DispatchQueue.main.async {
//                                    cell.poster.image = showPoster
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//        }
        
        
        return cell
    }
    
}
