//
//  HighlightTableViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class HighlightTableViewCell: UITableViewCell, HighlightViewModelObserver {

    var collectionView:UICollectionView?
    var highlightViewModel:HighlightViewModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.collectionBootstrap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionBootstrap() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: 375, height: 176)
        self.collectionView = UICollectionView(frame: collectionViewFrame,
                                               collectionViewLayout: flowLayout)
        
        self.highlightViewModel = HighlightViewModel()
        self.highlightViewModel?.observer = self
        self.collectionView?.dataSource = self.highlightViewModel
        self.collectionView?.delegate = self
        
        self.collectionView?.backgroundColor = .blue
        self.contentView.addSubview(self.collectionView!)
    }

    func updated(viewModel data: [Show]) {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

extension HighlightTableViewCell: UICollectionViewDelegateFlowLayout {

    private var sectionInsets:UIEdgeInsets { return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6) }
    private var itemsPerRow:CGFloat { return 1.3 }
    private var itemsPerColumn: CGFloat { return 1 }
    private var itemsOriginalWidth:CGFloat { return 1920 } /// Using the original size of the poster
    private var itemsOriginalHeight:CGFloat { return 1080 } /// Using the original size of the poster
    private var footerInSectionSize:CGFloat { return 75 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionWidth = collectionView.frame.width

        /// Calculate width
        let widthPaddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
        let widthAvailable = collectionWidth - widthPaddingSpace
        let widthForItem = widthAvailable/self.itemsPerRow

        /// Calculate height proportion by its width
        /// Formula (original height / original width) x new width = new height
        let heightForItem = (self.itemsOriginalHeight/self.itemsOriginalWidth)*widthForItem
        return CGSize(width: widthForItem, height: heightForItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.top
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.footerInSectionSize)
    }

}
