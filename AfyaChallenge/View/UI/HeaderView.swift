//
//  HeaderView.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 27/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate{
    func headerView(_ headerView:HeaderView, favouriteButtonDidChanceTo status:Bool)
}

class HeaderView:UIView {

    var delegate:HeaderViewDelegate?
    private var infoBoxFavourite:InfoBoxView<UIButton>?
    private var infoBoxRating:InfoBoxView<UILabel>?
    
    var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingHead
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Bold", size: 36)
        label.tintColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    var ratingLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Thin", size: 32)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    var favouriteButton:UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        } else {
            // Fallback on earlier versions
        }
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(buttonClick), for: .touchDown)
        button.tintColor = #colorLiteral(red: 0.8274509804, green: 0.1098039216, blue: 0.3568627451, alpha: 1)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.infoBoxFavourite = InfoBoxView(title: "Favourite", component: self.favouriteButton)
        self.infoBoxRating = InfoBoxView(title: "Rating", component: self.ratingLabel)
        
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.infoBoxFavourite!)
        self.stackView.addArrangedSubview(self.infoBoxRating!)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClick(){
        //self.dismiss(animated: true, completion: nil)
        print("ADASDASD")
        self.favouriteButton.isSelected.toggle()
        guard let delegate = self.delegate else { return }
        delegate.headerView(self, favouriteButtonDidChanceTo: self.favouriteButton.isSelected)
    }
    

}

