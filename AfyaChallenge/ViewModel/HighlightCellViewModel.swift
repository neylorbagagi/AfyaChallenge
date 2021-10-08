//
//  HighlightViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 07/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

///TODO: getImages on get one image and one type of image? the name is wrong

class HighlightCellViewModel: NSObject {
    
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
        
        if let cachedImage = Cache.share.storage.object(forKey: data.images["background"] as AnyObject){
            self.image = cachedImage
            return
        }
        
        if let imageUrl = data.images["background"]{
            guard let url = URL(string: imageUrl) else {
                print("Invalid image url")
                return
            }
            loadImage(from: url) { (image) in
                guard let validImage = image else { return }
                Cache.share.storage.setObject(validImage, forKey: url.absoluteString as AnyObject)
                self.image = validImage
                return
            }
        }
        
        RealmManager.share.getImages(byShow: data) { (imageUrl, error) in
            guard let url = URL(string: imageUrl) else { return }
            loadImage(from: url) { (image) in
                guard let validImage = image else { return }
                Cache.share.storage.setObject(validImage, forKey: url.absoluteString as AnyObject)
                self.image = validImage
            }
        }
    }
}
