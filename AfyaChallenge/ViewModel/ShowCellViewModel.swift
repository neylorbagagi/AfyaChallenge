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
    
//          guard let url = URL(string: show.images["medium"] ?? "") else{
    //                print("Invalid image url")
    //                self.poster.image = UIImage()
    //                completion(show.id,nil)
    //                return
    //            }
    //            loadImage(from: url) { (image) in
    //                DispatchQueue.main.async {
    //                    self.poster.image = image
    //                    completion(show.id,image)
    //                }
    //            }
    
    
    func requestImage(){
        if let imageUrl = data.images["medium"]{
            guard let url = URL(string: imageUrl) else { return }
            loadImage(from: url) { (image) in
                self.image = image
            }
        } else {
            print("Invalid image url")
        }
    }
}
