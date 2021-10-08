//
//  ShowCellViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 20/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class ShowCellViewModel: NSObject {
    
    private var data:Show
    var name:String
    var image:UIImage? {
        didSet {
            self.bind?(self.image ?? UIImage())
        }
    }
    
    var bind:((UIImage) -> Void)?
    
    init(data:Show) {
        self.data = data
        self.name = data.name
    }

    
    func requestImage(){
        
        if let cachedImage = Cache.share.storage.object(forKey: data.images["medium"] as AnyObject){
            self.image = cachedImage
            return
        }
        
        if let imageUrl = data.images["medium"]{
            guard let url = URL(string: imageUrl) else {
                print("Invalid image url")
                return
            }
            loadImage(from: url) { (image) in
                guard let validImage = image else { return }
                Cache.share.storage.setObject(validImage, forKey: url.absoluteString as AnyObject)
                self.image = validImage
            }
        }
    }
}
