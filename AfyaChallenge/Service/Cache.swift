//
//  Cache.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 04/10/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class Cache {
    
    static let share = Cache()
    var storage = NSCache<AnyObject, UIImage>()
    
    
}
