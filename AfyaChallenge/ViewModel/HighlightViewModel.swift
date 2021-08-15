//
//  HighlightViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 07/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

protocol HighlightViewModelObserver {
    func updated(viewModel data:[Show])
}

class HighlightViewModel: NSObject, UICollectionViewDataSource {
    
    private var data:[Show] = []
    private var imageCache:[Int:UIImage] = [:]
    var observer:HighlightViewModelObserver?
    
    override init() {
        super.init()
        self.requestData(limitedIn: 5)
    }
    
    func requestData(limitedIn limit:Int){
        
        

        
//        APIClient.shared.getUpdates { (data, error) in
//            guard error == nil else {
//                print(error.debugDescription)
//                return
//            }
//
//            var showsToQueryFor:[Int] = []
//            for key in (data?.keys)!{
//                showsToQueryFor.append(Int(key)!)
//            }
//
//            self.requestShows(idList: Array(showsToQueryFor.prefix(limit)))
//        }
    }
    
    func requestShows(idList list:[Int]){
//        APIClient.shared.getShows(forList:list) { (data, error) in
//            guard error == nil else {
//                print(error.debugDescription)
//                return
//            }
//            //self.data = data
//            self.requestShowsHighlight(shows: data)
//        }
    }
    
//    func requestShowsHighlight(shows:[ACShow]){
//
//        let dispatchGroup = DispatchGroup()
//
//        dispatchGroup.enter()
//        for show in shows{
//
//            APIClient.shared.getShowImage(forShow: show.id) { (data, error) in
//                guard error == nil else {
//                    print(error.debugDescription)
//                    return
//                }
//
//                let largeImages:[ACShowImage] = (data?.filter({$0.type == "background"}))!
//                let highlight = largeImages.first(where: {$0.resolutions.original.width >= 1920})
//
//                let poster = ACPoster(medium: (highlight?.resolutions.original.url)!)
//                let updatedShow = ACShow(show:show, imageHighlight:poster)
//                self.data.append(updatedShow)
//                dispatchGroup.leave()
//            }
//
//
//        }
//
//        dispatchGroup.notify(queue: .main) {
//            print("All posters updated")
//            self.notifyDataUpdated()
//        }
//
//
////        APIClient.shared.getShows(forList:list) { (data, error) in
////            guard error == nil else {
////                print(error.debugDescription)
////                return
////            }
////            self.data = data
////            self.notifyDataUpdated()
////        }
//
//
//
//
//        //self.notifyDataUpdated()
//    }
    
    
    func notifyDataUpdated(){
        guard self.observer != nil else {
            print("No observer set fo HighlightViewModel.class")
            return
        }
        
        observer?.updated(viewModel: self.data)
    }
    
    /// DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.register(HighlightCollectionViewCell.self, forCellWithReuseIdentifier: "highlightCollectionCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "highlightCollectionCell", for: indexPath) as! HighlightCollectionViewCell
        
        
        let show = self.data[indexPath.row]
        
        // Configure the cell
        cell.poster.image = UIImage()
        
        // TODO: Put it on a func
//        if let showImagePath = show.imageHighlight?.medium {
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
        
        cell.backgroundColor = .red
        return cell
        
    }
    
    
    
    
}
