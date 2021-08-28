//
//  ShowCollectionViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 31/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol ShowCollectionViewModelDelegate {
    func didDataUpdate(_ viewModel:ShowCollectionViewModel, data:[Show],_ collectionMode:ShowCollectionMode,_ error:Error?)
}

public enum ShowCollectionMode {
    case page
    case search
}

class ShowCollectionViewModel: NSObject {
    
    private var data:[Show] = []
    private var filteredData:[Show] = []
    private let imagesCache = NSCache<NSNumber,UIImage>()
    private var currentePage:Int = 0
    var delegate:ShowCollectionViewModelDelegate?
    var collectionMode:ShowCollectionMode = .page
    
    // T E S T  T E S T  T E S T  T E S T  T E S T  T E S T
    //    var notificationToken:NotificationToken?
    //    var realm = try! Realm()
    //
    //    override init() {
    //        let showCollection = self.realm.objects(Show.self)
    //        self.notificationToken = showCollection.observe { change in
    //            switch change {
    //                case .initial:
    //                    //self.collectionView?.reloadData()
    //                    print(".initial")
    //                case .error(let error):
    //                    fatalError("\(error)")
    //                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
    //                    print(".update")
    //                }
    //        }
    //    }
    // T E S T  T E S T  T E S T  T E S T  T E S T  T E S T
    
    func requestData(_ string:String = "") {
        
        guard let delegate = self.delegate else{
            print("No delegate:ShowCollectionViewModelDelegate set")
            return
        }
        
        switch self.collectionMode {
        case .search:
            
            //self.filteredData = Array(self.realm.objects(Show.self).filter("name CONTAINS '\(string)'"))
//            delegate.didDataUpdate(self, data:data, self.collectionMode, nil)
            
            
            RealmManager.share.getShows(byString: string) { (data, error) in
                guard error == nil else{
                    delegate.didDataUpdate(self, data:[], self.collectionMode, error)
                    return
                }
                self.filteredData.append(contentsOf: data)// = data
                delegate.didDataUpdate(self, data:data, self.collectionMode, nil)
            }
            
        default:
            RealmManager.share.getShows(byPage: currentePage) { (data, error) in
                guard error == nil else{
                    delegate.didDataUpdate(self, data:[], self.collectionMode, error)
                    return
                }
                self.data.append(contentsOf: data)
                self.currentePage += 1
                delegate.didDataUpdate(self, data: data, self.collectionMode, nil)
            }
        }
    }

    func switchCollectionMode(to mode:ShowCollectionMode){
        self.filteredData = []
        self.collectionMode = mode
    }
    
    private func loadImage(from url:String,completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: url) else{
            print("Invalid image url")
            return
        }
        
        DispatchQueue.global().async {
            //let url = URL(string: url)!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        
    }
    
    
}

extension ShowCollectionViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.collectionMode {
        case .search:
            return self.filteredData.count
        default:
            return self.data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCollectionCell", for: indexPath) as! ShowCollectionViewCell
        
        let show:Show
        switch self.collectionMode {
            case .search:
                show = self.filteredData[indexPath.item]
            default:
                show = self.data[indexPath.item]
        }
        
        let itemNumber = NSNumber(value: show.id)
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
    
    
    
}


//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if (kind == UICollectionElementKindSectionHeader){
//            let searchHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "searchCollectionHeader", for: indexPath)
//            return searchHeader
//        }
//
//        return UICollectionReusableView()
//    }
//
