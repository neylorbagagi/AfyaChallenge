//
//  SearchViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/10/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class SearchViewModel:NSObject {
    
    private var data:[Show] = [] {
        didSet {
            self.bind?()
        }
    }
    private var filterString:String = ""
    private var notificationToken:NotificationToken?
    private var realm = try? Realm()
    
    var bind:(()->Void)?
    
    override init() {
        super.init()
        
        guard let realm = self.realm else {
            print("No Realm instance")
            return
        }
        
        let collection = realm.objects(Show.self)
        self.notificationToken = collection.observe({ change in
            switch change {
            case .initial(_):
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                let newItems = collection.objects(at: IndexSet(insertions)).filter { show in
                    show.name.contains(self.filterString)
                }
                self.data.append(contentsOf: newItems)
            case .error(_):
                print("error")
            }
        })
        
        
    }
    
    deinit {
        self.notificationToken?.invalidate()
    }
    
    func requestData(searchString string:String){
        guard let realm = self.realm else {
            print("No Realm instance")
            return
        }
        self.filterString = string
        
        self.data = Array(realm.objects(Show.self).filter("name contains[c] %@",self.filterString))
        print("Local search itens \(self.data.count)")
        
        
        DispatchQueue(label: "backgroundRequest", qos: .background).async {
            RealmManager.share.getShows(byString: string) { (data, error) in
                guard error == nil else{ return }
            }
        }
    }
    
    func selectedShow(_ indexPath:IndexPath) -> Show {
        return self.data[indexPath.row]
    }
}

extension SearchViewModel: UICollectionViewDataSource {
    
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
    
