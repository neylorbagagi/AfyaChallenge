//
//  SummaryView.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 30/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class SummaryView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    var statusLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .right
        label.font = UIFont(name: "SFProText-Bold", size: 14)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    var genderLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Thin", size: 14)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    var textView:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .none
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.isScrollEnabled = false;
        textView.font = UIFont(name: "SFProText-Regular", size: 16)
        textView.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return textView
    }()
    
    
    init() {
        super.init(frame: CGRect())
                
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.genderLabel)
        self.stackView.addArrangedSubview(self.statusLabel)
        
        self.addSubview(self.textView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
                        
            self.textView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 2),
            self.textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            self.textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
