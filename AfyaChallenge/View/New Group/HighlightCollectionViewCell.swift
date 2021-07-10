//
//  HighlightCollectionViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HighlightCollectionViewCell: UICollectionViewCell {
    
    var poster:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.poster = UIImageView(frame: contentView.frame)
        self.poster.layer.cornerRadius = 6
        
        self.poster.layer.masksToBounds = false
        self.poster.clipsToBounds = true
        
        self.addSubview(self.poster)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
