//
//  HighlightTableViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HighlightTableViewCell: UITableViewCell {

    var collectionView:UICollectionView?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blue
        
        let collectionViewRect = CGRect(x: 0, y: 0,width: 375, height: 147)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame:collectionViewRect, collectionViewLayout: flowLayout)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = .purple
        self.contentView.addSubview(self.collectionView!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
}

extension HighlightTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.register(HighlightCollectionViewCell.self, forCellWithReuseIdentifier: "highlightCollectionCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "highlightCollectionCell", for: indexPath)
        
        cell.backgroundColor = .red
        
        return cell
        
    }
}

extension HighlightTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 135)
    }
    
    
    
}
