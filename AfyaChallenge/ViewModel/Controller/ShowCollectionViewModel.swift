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


class ShowCollectionViewModel: NSObject {
    
    public var notificationToken:NotificationToken?
    private var realm = try? Realm()
    
    private var data:[Show] = [] {
        didSet {
            self.dataBind?()
        }
    }
    
    var dataBind:(() -> Void)?
    
    override init() {
        super.init()
        self.startRealmNotification()
    }
    
    func requestData() {
        
        var pageToRequest = 0
        if UserDefaults.standard.object(forKey: "pageToRequest") != nil {
            pageToRequest = UserDefaults.standard.integer(forKey: "pageToRequest")
        }
        
        RealmManager.share.getShows(byPage: pageToRequest) { (data, error) in
            guard error == nil else{ return }
            pageToRequest += 1
            UserDefaults.standard.setValue(pageToRequest, forKey: "pageToRequest")
        }
        
    }

    func stopRealmNotification(){
        self.notificationToken?.invalidate()
        self.notificationToken = nil
    }
    
    func startRealmNotification(){
        guard let realm = self.realm else {
            print("No Realm instance")
            return
        }
        
        let data = realm.objects(Show.self).sorted(byKeyPath: "id", ascending: true)
        self.notificationToken = data.observe { change in
            switch change {
                case .initial:
                    if UserDefaults.standard.object(forKey: "pageToRequest") != nil ||
                       UserDefaults.standard.integer(forKey: "pageToRequest") == 0 {
                        self.requestData()
                    } else {
                        self.data = Array(data)
                    }
            
                case .error(let error):
                    print(".error: \(error)")
                    
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    self.data = Array(data)
            }
        }
    }

    
    func selectedShowForSegue(_ indexPath:IndexPath) -> Show {
        return self.data[indexPath.row]
    }
}

extension ShowCollectionViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCollectionCell", for: indexPath) as! ShowCollectionViewCell
        let show = self.data[indexPath.item]
        
        let viewModel = ShowCellViewModel(data: show)
        cell.bindingFrom(viewModel)
        
        return cell
    }
    
    
    
}
