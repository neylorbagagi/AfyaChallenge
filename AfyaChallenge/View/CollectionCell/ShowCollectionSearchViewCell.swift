//
//  ShowCollectionSearchViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 18/08/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class SearchCollectionHeader: UICollectionReusableView {
    
    let searchBar:UISearchBar!
    
    override init(frame: CGRect) {
        
        
        self.searchBar = UISearchBar(frame: frame)
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.purple
        
        self.addSubview(self.searchBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
