//
//  ShowTableViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 26/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    var collectionView:UICollectionView?
    var collectionViewData:ShowTableViewCellCollectionData?
    var collectionViewDelegate:ShowTableViewCellCollectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.collectionBootstrap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func collectionBootstrap() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: 375, height: 176)
        self.collectionView = UICollectionView(frame: collectionViewFrame,
                                               collectionViewLayout: flowLayout)
        
        self.collectionView?.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCell")
        self.collectionViewData = ShowTableViewCellCollectionData()
        self.collectionViewDelegate = ShowTableViewCellCollectionDelegate()
        
        self.collectionView?.dataSource = self.collectionViewData
        self.collectionView?.delegate = self.collectionViewDelegate
        
        self.collectionView?.backgroundColor = .blue
        self.contentView.addSubview(self.collectionView!) /// TODO:
    }
    
}


