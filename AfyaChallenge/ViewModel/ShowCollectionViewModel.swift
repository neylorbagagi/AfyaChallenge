//
//  ShowCollectionViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 31/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class ShowCollectionViewModel: NSObject, UICollectionViewDataSource {
    
    var data:[Show] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCell", for: indexPath)
        cell.backgroundColor = .green
        let show = self.data[indexPath.row]
        
        return cell
    }
    
    
    
    
}
