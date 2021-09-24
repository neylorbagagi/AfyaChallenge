//
//  ShowTableViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 20/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

/// TODO: cache images to userDefaults

class ShowTableViewModel: NSObject {

    var sectionTitle:String?
    var data:[Show] = [] {
        didSet {
            self.bind?(data)
        }
    }
    private let imagesCache = NSCache<NSNumber,UIImage>()
    var sectionType:HomeTableViewSection?
    
    var bind:(([Show]) -> Void)?
    
    init(sectionType:HomeTableViewSection) {
        super.init()
        self.sectionTitle = "\(sectionType)"
        self.sectionType = sectionType
    }
    
    func requestData(){
        /// requestind Data Here
        switch self.sectionType {
            case .highlights:
                RealmManager.share.getShows(byIdList: [76,216,49,161,28276,38963,1371,33352,210,29]) { (data, error) in
                    guard error == nil else { return }
                    self.data = Array(data.prefix(10))
                }
            case .favourites:
                RealmManager.share.getFavourites() {(data, error) in
                    guard error == nil else { return }
                    self.data = data
                }
            case .updates:
                RealmManager.share.getUpdates() {(data, error) in
                    guard error == nil else { return }
                    
                    self.data = Array(data.prefix(10))
                }
            case .rating:
                RealmManager.share.getRating(){(data, error) in
                    guard error == nil else { return }
                    self.data = Array(data.prefix(10))
                }
            default:
                RealmManager.share.getShows(byString: "Rick") { (data, error) in
                    guard error == nil else { return }
                    self.data = Array(data.prefix(10))
                }
        }
        
        

    }
}

extension ShowTableViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        let show = self.data[indexPath.row]
        
        
        switch self.sectionType {
        case .highlights:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "highlightCell", for: indexPath) as! HighlightCollectionViewCell
            let viewModel = HighlightCellViewModel(data: show)
            cell.bindingFrom(viewModel)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCell", for: indexPath) as! ShowCollectionViewCell
            let viewModel = ShowCellViewModel(data: show)
            cell.bindingFrom(viewModel)
            
            return cell
        }

    }
    
}
