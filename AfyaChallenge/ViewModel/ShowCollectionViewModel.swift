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
    func didDataUpdate(_ viewModel:ShowCollectionViewModel, _ collectionMode:ShowCollectionMode,_ error:Error?)
}

public enum ShowCollectionMode {
    case page
    case search
}

class ShowCollectionViewModel: NSObject {
    
    private var notificationToken:NotificationToken?
    private var realm = try? Realm()
    
    private var data:[Show] = []
    private var filterString:String = ""
    private var dataFiltered:[Show] {
        self.data.filter( {$0.name.localizedStandardContains(self.filterString) })
    }
    
    private let imagesCache = NSCache<NSNumber,UIImage>()
    var delegate:ShowCollectionViewModelDelegate?
    var collectionMode:ShowCollectionMode = .page
    
    override init() {
        super.init()
        
        guard let realm = self.realm else {
            print("No Realm instance")
            return
        }
        
        let data = realm.objects(Show.self)
        self.notificationToken = data.observe { change in
            switch change {
                case .initial:
                    print(".initial")
                    self.data = Array(data)
                    
                    if data.count == 0 {
                        self.requestData()
                    } else {
                        self.notifyView()
                    }
            
                case .error(let error):
                    self.notifyView(error)
                    
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    print(".update")
                    self.data = Array(data)
                    self.notifyView()
                }
        }
    }
    
    func notifyView(_ error:Error? = nil) {
        guard let delegate = self.delegate else{
            print("No delegate:ShowCollectionViewModelDelegate set")
            return
        }
        delegate.didDataUpdate(self, self.collectionMode, error)
    }
    
    func requestData(_ string:String = "") {
        switch self.collectionMode {
            case .search:
                self.filterString = string
                self.notifyView()
                
                RealmManager.share.getShows(byString: string) { (data, error) in
                    guard error == nil else{
                        self.notifyView(error)
                        return
                    }
                }
            default:
                var currentePage = 0
                if UserDefaults.standard.object(forKey: "currentePage") != nil {
                    currentePage = UserDefaults.standard.integer(forKey: "currentePage")
                }
                
                RealmManager.share.getShows(byPage: currentePage) { (data, error) in
                    guard error == nil else{
                        self.notifyView(error)
                        return
                    }
                    currentePage += 1
                    UserDefaults.standard.setValue(currentePage, forKey: "currentePage")
                }
        }
    }

    func switchCollectionMode(to mode:ShowCollectionMode){
        self.collectionMode = mode
        if mode == .page {
            self.filterString = ""
        }
    }
    
}

extension ShowCollectionViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.collectionMode {
        case .search:
            return self.dataFiltered.count
        default:
            return self.data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCollectionCell", for: indexPath) as! ShowCollectionViewCell
        
        let show:Show
        switch self.collectionMode {
            case .search:
                show = self.dataFiltered[indexPath.item]
            default:
                show = self.data[indexPath.item]
        }
        
        let itemNumber = NSNumber(value: show.id)
        let cachedImage:UIImage? = self.imagesCache.object(forKey: itemNumber)
       
        cell.set(show: show, image: cachedImage) { (id, image) in
            guard let image = image else { return }
            self.imagesCache.setObject(image, forKey: NSNumber(value:id))
        }

        return cell
    }
    
}
