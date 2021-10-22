//
//  ShowCollectionViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO:Lentidão para abrir a tela de detalhes, deve abrir e depois carregar episodios e imagens


class ShowCollectionViewCell: UICollectionViewCell {
    
    var viewModel:ShowCellViewModel?
    
    var poster:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true // this keeps cornerRadius property
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Thin", size: 16)
        label.tintColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        self.layer.cornerRadius = 6
        
        self.addSubview(self.nameLabel)
        self.addSubview(self.poster)
        

        NSLayoutConstraint.activate([
            
            self.poster.topAnchor.constraint(equalTo: self.topAnchor),
            self.poster.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.poster.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.poster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
        ])
        
    }
    
    override func prepareForReuse() {
        self.poster.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindingFrom(_ viewModel:ShowCellViewModel){
        self.viewModel = viewModel
        self.nameLabel.text = viewModel.name
        viewModel.bind = {(image) in
            self.poster.image = image
        }
        viewModel.requestImage()
    }
    
}
