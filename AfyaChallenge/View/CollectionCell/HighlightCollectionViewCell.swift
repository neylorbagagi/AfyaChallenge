//
//  HighlightCollectionViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HighlightCollectionViewCell: UICollectionViewCell {
    
    var viewModel:HighlightCellViewModel?
    var poster:UIImageView!
    var name:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.poster = UIImageView(frame: contentView.frame)
        self.poster.layer.cornerRadius = 6
        self.poster.layer.masksToBounds = false
        self.poster.clipsToBounds = true
        self.poster.layer.borderWidth = 1.0
        self.poster.layer.borderColor = #colorLiteral(red: 0.9210698009, green: 0.933000505, blue: 0.9054066539, alpha: 1)
        
        self.name = UILabel(frame: contentView.frame)
        self.name.numberOfLines = 0
        self.name.lineBreakMode = .byWordWrapping
        self.name.textAlignment = .center
        self.name.tintColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2352941176, alpha: 1)
        
        self.addSubview(self.name)
        self.addSubview(self.poster)

    }
    
    override func prepareForReuse() {
        self.poster.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindingFrom(_ viewModel:HighlightCellViewModel){
        self.viewModel = viewModel
        self.name?.text = viewModel.name
        viewModel.bind = {(image) in
            self.poster.image = image
        }
        viewModel.requestImage()
    }
    
}
