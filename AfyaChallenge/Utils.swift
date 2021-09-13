//
//  Utils.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 09/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

public func loadImage(from url:URL,completion: @escaping (UIImage?) -> ()) {
    guard let data = try? Data(contentsOf: url) else { return }
    let image = UIImage(data: data)
    completion(image)
}
