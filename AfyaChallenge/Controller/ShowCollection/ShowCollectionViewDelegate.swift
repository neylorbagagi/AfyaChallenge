//
//  ShowCollectionViewDelegate.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 22/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit


class ShowCollectionViewDelegate:NSObject,UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// We don't want that requests takes to long, so I will call for ever page when user reachs de scrollView bottom
        let scrollViewHeightSize:CGFloat = scrollView.frame.size.height
        let scrollViewContentSize:CGFloat = scrollView.contentSize.height
        let scrollViewPosition = scrollViewContentSize-scrollViewHeightSize
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > scrollViewPosition{ //&& self.isRequestingData == false
            //requestData(page:self.pageOffset)
            print("Reached the bottom")
        }
    }
    
}
