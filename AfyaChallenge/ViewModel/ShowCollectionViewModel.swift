//
//  ShowCollectionViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 31/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

protocol ShowCollectionViewModelDelegate {
    func didDataUpdate(_ viewModel:ShowCollectionViewModel, data:[Show], error:Error?)
}

class ShowCollectionViewModel: NSObject, UICollectionViewDataSource {
    
    private var data:[Show] = []
    private let imagesCache = NSCache<NSNumber,UIImage>()
    private var currentePage:Int = 0
    var delegate:ShowCollectionViewModelDelegate?
    
    func requestData() {
        
        RealmManager.share.getShows(byPage: currentePage) { (data, error) in
            guard let delegate = self.delegate else{
                print("No delegate:ShowCollectionViewModelDelegate set")
                return
            }
            
            guard error == nil else{
                delegate.didDataUpdate(self, data:[],error:error)
                return
            }
            
            self.data.append(contentsOf: data)
            self.currentePage += 1
            
            delegate.didDataUpdate(self, data: data,error: nil)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCollectionCell", for: indexPath) as! ShowCollectionViewCell
        let show = self.data[indexPath.item]
        let itemNumber = NSNumber(value: indexPath.item)
        
        if let cachedImage = self.imagesCache.object(forKey: itemNumber) {
            cell.poster.image = cachedImage
        } else {
            self.loadImage(from:show.images["medium"]!) {(image) in
                guard let image = image else { return }
                cell.poster.image = image
                self.imagesCache.setObject(image, forKey: itemNumber)
            }
        }

        
        return cell
    }
    
    private func loadImage(from url:String,completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            let url = URL(string: url)!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    
}
