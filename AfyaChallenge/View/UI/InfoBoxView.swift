//
//  InfoBoxView.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 27/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class InfoBoxView<T:UIView>: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 2
        return stackView
    }()
    
    var title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.text = ""
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    var component:T?
    
    init(title string:String, component:T) {
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 61, height: 61)))
        
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        
        self.layer.cornerRadius = 6
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.text = string
        
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.title)
        
        self.component = component
        
        guard let component = self.component else { return }
        self.stackView.addArrangedSubview(component)
        
        
        
        NSLayoutConstraint.activate([
            
            self.widthAnchor.constraint(equalToConstant: 61),
            self.heightAnchor.constraint(equalToConstant: 61),
            
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            self.title.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 2),
            self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            self.title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.title.heightAnchor.constraint(equalToConstant: 14.5),
            
            component.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            component.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
