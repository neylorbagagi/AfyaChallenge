//
//  ShowCollectionViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO: add to ViewModel

class ShowCollectionViewCell: UICollectionViewCell {
    
    var poster:UIImageView!
    var title:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.poster = UIImageView(frame: contentView.frame)
        self.poster.layer.cornerRadius = 6
        self.poster.layer.masksToBounds = false
        self.poster.clipsToBounds = true
        self.poster.layer.borderWidth = 1.0
        self.poster.layer.borderColor = #colorLiteral(red: 0.9210698009, green: 0.933000505, blue: 0.9054066539, alpha: 1)
        
        self.title = UILabel(frame: contentView.frame)
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        self.title.textAlignment = .center
        self.title.tintColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2352941176, alpha: 1)
        
        self.addSubview(self.title)
        self.addSubview(self.poster)

    }
    
    override func prepareForReuse() {
        self.poster.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(show:Show, image:UIImage? = nil, completion: @escaping (_ showId:Int, _ image:UIImage?) -> Void) {
        self.title.text = show.name
        
        if let image = image {
            self.poster.image = image
            completion(show.id,nil)
        } else {
            guard let url = URL(string: show.images["medium"] ?? "") else{
                print("Invalid image url")
                self.poster.image = UIImage()
                completion(show.id,nil)
                return
            }
            loadImage(from: url) { (image) in
                DispatchQueue.main.async {
                    self.poster.image = image
                    completion(show.id,image)
                }
            }
        }
    }
    
}
