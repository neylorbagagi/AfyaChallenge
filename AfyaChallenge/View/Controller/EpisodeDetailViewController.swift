//
//  EpisodeDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 12/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    var viewModel:EpisodeDetailViewModel?
    
    // O U T L E T S
    var closeButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("close", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8274509804, green: 0.1098039216, blue: 0.3568627451, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 18)
        button.addTarget(self, action: #selector(closeDetailView), for: .touchDown)
        return button
    }()
    
    var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true // this keeps cornerRadius property
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
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
    
    var summaryView:SummaryView = {
        let summaryView = SummaryView()
        summaryView.layer.cornerRadius = 6
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        return summaryView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        guard let viewModel = self.viewModel else { return }
        self.configure(viewModel: viewModel)
        
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.summaryView)
        
        NSLayoutConstraint.activate([
            
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            self.closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                        
            self.scrollView.topAnchor.constraint(equalTo: self.closeButton.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9/16),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            self.nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.summaryView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
            self.summaryView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.summaryView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.summaryView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
            
        ])
    }

    func configure(viewModel:EpisodeDetailViewModel){
        
        viewModel.bind = { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        viewModel.requestImage()
        
        self.nameLabel.text = viewModel.name
        
        self.summaryView.genderLabel.text = viewModel.season
        self.summaryView.statusLabel.text = viewModel.duration
        self.summaryView.textView.text = viewModel.summary
        
    }
    
    @objc func closeDetailView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
