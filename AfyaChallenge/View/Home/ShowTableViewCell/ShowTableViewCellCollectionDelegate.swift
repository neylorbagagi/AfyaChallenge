//
//  ShowTableViewCellCollectionDelegate.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 26/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit


class ShowTableViewCellCollectionDelegate:NSObject, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
               didSelectItemAt indexPath: IndexPath) {
        print("Did Select")
    }
}
