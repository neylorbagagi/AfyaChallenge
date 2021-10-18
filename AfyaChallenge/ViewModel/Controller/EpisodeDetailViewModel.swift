//
//  EpisodeDetailViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 13/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class EpisodeDetailViewModel:NSObject {
    
    private var data:Episode?
    var name:String?
    var season:String?
    var duration:String?
    var summary:String?
    var bind:((UIImage) -> Void)?
    var image:UIImage? {
        didSet {
            self.bind?(image ?? UIImage())
        }
    }
    
    init(data:Episode) {
        super.init()
        self.data = data
        self.name = "\(data.number). \(data.name)"
        self.season = "season \(data.season)"
        self.duration = "duration \(data.runtime)min"
        self.summary = data.summary.replacingOccurrences(of: "<[^>]+>", with: "",
                                                    options: .regularExpression, range: nil)
    }
    
    func requestImage(){
        guard let url = URL(string: self.data?.images["medium"] ?? "") else {
            print("Image Load Error")
            self.image = UIImage(named: "no_image")
            return
        }
        loadImage(from: url) { (image) in
            self.image = image
        }
    }
}
