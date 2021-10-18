//
//  ShowTableViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 20/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
/// TODO: cache images to userDefaults
/// TODO: Use loading in views

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
    
    var token:NotificationToken?
    
    init(sectionType:HomeTableViewSection) {
        super.init()
        self.sectionTitle = "\(sectionType)"
        self.sectionType = sectionType
        
        if self.sectionType == HomeTableViewSection.favourites {
            guard let realm = try? Realm() else{
                fatalError("Could not to load Realm")
            }
            
            //realm.objects(Show.self).filter("favourite == true")
            self.token = realm.objects(Show.self).filter("favourite == true").observe() { changes in
                switch changes {
                    case .initial:
                        // Results are now populated and can be accessed without blocking the UI
                        print("initial")
                        break
                    case .update(_, let deletions, let insertions, let modifications):
                        print("updated")
                        RealmManager.share.getFavourites() {(data, error) in
                            guard error == nil else { return }
                            self.data = data
                        }
                        break
                    case .error(let err):
                        // An error occurred while opening the Realm file on the background worker thread
                        fatalError("\(err)")
                        break
                }
            }
            
        }
    }
    
    deinit {
        if (self.token != nil){
            self.token?.invalidate()
        }
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
