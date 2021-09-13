//
//  ShowDetailView.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 08/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

protocol ShowDetailViewDataSource {
    func showDetailView(_ showDetailView:ShowDetailView, stringForTextComponent component:ShowDetailViewTextComponent) -> String?
    func showDetailView(_ showDetailView:ShowDetailView, imageForImageView imageView:UIImageView) -> UIImage?
    func showDetailView(_ showDetailView:ShowDetailView, enableDayWithLabel label:UILabel) -> Bool? 
    func showDetailView(_ showDetailView:ShowDetailView, numberOfRowsForTable tableView:UITableView) -> Int
    func showDetailView(_ showDetailView:ShowDetailView, numberOfSectionsForTable tableView:UITableView) -> Int
    func showDetailView(_ showDetailView:ShowDetailView, statusForFavouriteButton button:UIButton) -> Bool
}

enum ShowDetailViewTextComponent {
    case name
    case rating
    case gender
    case channel
    case time
    case summary
}

class ShowDetailView: UIView {

    var modelView:ShowDetailViewModel?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var channel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var scheduleDayMon: UILabel!
    @IBOutlet weak var scheduleDayTue: UILabel!
    @IBOutlet weak var scheduleDayWed: UILabel!
    @IBOutlet weak var scheduleDayThu: UILabel!
    @IBOutlet weak var scheduleDayFri: UILabel!
    @IBOutlet weak var scheduleDaySat: UILabel!
    @IBOutlet weak var scheduleDaySun: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet var episodeTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var favourite: UIButton!
    
    
    var scheduleDayLabels:[UILabel] {
            return [self.scheduleDayMon, self.scheduleDayTue, self.scheduleDayWed,
                    self.scheduleDayThu, self.scheduleDayFri, self.scheduleDaySat,
                    self.scheduleDaySun]
        }
    
    private let reuseIdentifier = "EpisodeCellIdentifier"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    private func configure(){
        guard let dataSource = self.modelView else { return }
        self.modelView?.delegate = self
        
        self.configureTextFields(dataSource: dataSource)
        self.configureScheduleDays(dataSource: dataSource)
        self.configureTableView(dataSource: dataSource)
        self.configureFavouriteButton(dataSource: dataSource)
        DispatchQueue.main.async {
            self.modelView?.requestShowImage()
            self.modelView?.requestShowEpisodes()
        }
        
        //SET AN NOTIFY VIEW HERE AFTER CONFIGURE()
    }
    
    private func configureTextFields(dataSource:ShowDetailViewDataSource){
        self.name.text = dataSource.showDetailView(self, stringForTextComponent: .name)
        self.rating.text = dataSource.showDetailView(self, stringForTextComponent: .rating)
        self.gender.text = dataSource.showDetailView(self, stringForTextComponent: .gender)
        self.channel.text = dataSource.showDetailView(self, stringForTextComponent: .channel)
        self.time.text = dataSource.showDetailView(self, stringForTextComponent: .time)
        self.summary.text = dataSource.showDetailView(self, stringForTextComponent: .summary)
    }
    
    private func configureImage(dataSource:ShowDetailViewDataSource){
        DispatchQueue.main.async {
            self.imageView.image = dataSource.showDetailView(self, imageForImageView: self.imageView)
        }
    }
    
    private func configureScheduleDays(dataSource:ShowDetailViewDataSource){
        for label in self.scheduleDayLabels {
            dataSource.showDetailView(self, enableDayWithLabel: label)
        }
    }
    
    private func configureTableView(dataSource:ShowDetailViewDataSource){
        
        self.episodeTableView?.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.episodeTableView?.dataSource = self.modelView!
        self.episodeTableView?.delegate = self
        self.configureTableViewConstraits(dataSource: dataSource)

    }
    
    private func configureTableViewConstraits(dataSource:ShowDetailViewDataSource) {
        let rows = dataSource.showDetailView(self, numberOfRowsForTable: self.episodeTableView)
        let sections = dataSource.showDetailView(self, numberOfSectionsForTable: self.episodeTableView)
        self.tableViewHeight.constant = CGFloat((Double(rows) * 57) + (Double(sections) * 30) + 36)
    }
    
    private func configureFavouriteButton(dataSource:ShowDetailViewDataSource) {
        
        self.favourite.addTarget(self, action: #selector(changeButtonState), for: UIControlEvents.touchDown)
        
        let buttonStatus = dataSource.showDetailView(self, statusForFavouriteButton: self.favourite)
        if buttonStatus {
            self.favourite.isSelected = true
        } else {
            self.favourite.isSelected = false
        }
    }
    
    @objc func changeButtonState(){
        self.favourite.isSelected.toggle()
        self.modelView?.updateFavorite()
    }
    
    public func reloadData(){
        self.configure()
    }
}



extension ShowDetailView: ShowDetailViewModelDelegate {
    
    func didDataUpdate(_ viewModel: ShowDetailViewModel, onComponent: UIView, _ error: Error?) {
        
        if type(of: onComponent) == UITableView.self{
            self.configureTableViewConstraits(dataSource: self.modelView!)
            self.episodeTableView.reloadData()
        }
        
        if type(of: onComponent) == UIImageView.self{
            self.configureImage(dataSource: self.modelView!)
        }
    }

}


extension ShowDetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
}
