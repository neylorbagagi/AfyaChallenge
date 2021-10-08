//
//  ScheduleView.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 26/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class ScheduleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var watchOnLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "watch on"
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    var networkLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Bold", size: 14)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    var timeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Thin", size: 18)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    private let headerStackView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 2
        return stack
    }()
    
    private let daysStackView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 0
        return stack
    }()
    
    let daysLabel:[UILabel] = {
        var labels:[UILabel] = []
        for day in ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"] {
            let label = UILabel()
            label.text = day
            label.font = UIFont(name: "SFProText-Bold", size: 18)
            label.textColor = #colorLiteral(red: 0.7400000095, green: 0.7400000095, blue: 0.7400000095, alpha: 1)
            labels.append(label)
        }
        return labels
    }()
    
    func enableLabelDays(forDays list:[String]){
        let prefixList = list.map({$0.prefix(3)})
        for dayPrefix in prefixList{
            for label in self.daysLabel{
                if (label.text ?? "" == dayPrefix){
                    label.textColor = #colorLiteral(red: 0.8270000219, green: 0.1099999994, blue: 0.3569999933, alpha: 1)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.headerStackView.addArrangedSubview(self.watchOnLabel)
        self.headerStackView.addArrangedSubview(self.networkLabel)
        self.addSubview(self.headerStackView)
        
        self.daysStackView.addArrangedSubview(self.timeLabel)
        for label in self.daysLabel{
            self.daysStackView.addArrangedSubview(label)
        }
        self.addSubview(self.daysStackView)
        
        
        NSLayoutConstraint.activate([
            self.headerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            
            self.daysStackView.topAnchor.constraint(equalTo: self.headerStackView.bottomAnchor),
            self.daysStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.daysStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            self.daysStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
