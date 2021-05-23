//
//  ShowCollectionViewDataSource.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 22/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

protocol ShowCollectionViewDataDelegate {
    
    func ccllectionViewData(didDataUpdated data:[ACShow])
    
}

class ShowCollectionViewData:NSObject,UICollectionViewDataSource{
    
    private var dataCache:[ACShow] = []
    private var imageCache:[Int:UIImage] = [:]
    private var pageOffset:Int = 0
    private var isRequestingData:Bool = false
    private var dataSearchCache:[ACShow] = []
    private var isSearchingData:Bool = false
    
    var delegate:ShowCollectionViewDataDelegate?
    
    override init() {
        super.init()
        self.requestData(page: 0)
    }
    
    func requestData(page:Int){
        self.isRequestingData = true
        APIClient.shared.getShows(forPage: page) { (data, error) in
            guard error == nil else {
                print(error.debugDescription)
                self.isRequestingData = false
                return
            }
            self.pageOffset += 1
            self.dataCache = self.dataCache + data

            if let delegate = self.delegate{
                delegate.ccllectionViewData(didDataUpdated: self.dataCache)
            }

            self.isRequestingData = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCache.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCell", for: indexPath) as! ShowCollectionViewCell
        let show = self.dataCache[indexPath.row]
        
        // Configure the cell
        cell.poster.image = UIImage()
        
        // TODO: Put it on a func
        if let showImagePath = show.image?.medium {
            
            if let image = self.imageCache[show.id]{
                cell.poster.image = image
            } else{
                if let imageUrl = URL(string: showImagePath){
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl){
                            if let showPoster = UIImage(data: imageData){
                                self.imageCache[show.id] = showPoster
                                DispatchQueue.main.async {
                                    cell.poster.image = showPoster
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
        return cell
    }

}
