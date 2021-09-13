//
//  ShowDetailViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 30/08/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//


///TODO: Remove the neet od import UIKIT and just retorn value to set do ot set it here
///TODO: The simpsons is broken

import Foundation
import UIKit
import RealmSwift

protocol ShowDetailViewModelDelegate{
    func didDataUpdate(_ viewModel:ShowDetailViewModel, onComponent:UIView, _ error:Error?)
}

class ShowDetailViewModel:NSObject {
    
    public var notificationToken:NotificationToken?
    private var realm = try? Realm()
    var delegate:ShowDetailViewModelDelegate?
    
    private var data:Show!
    private var image:UIImage?
    
    private var tableViewRows:Int? { return self.data.episodes.count }
    private var tableViewSections:Int? {
        var seasson = Set<Int>()
        for episode in self.data.episodes {
            seasson.insert(episode.season)
        }
        return seasson.count
    }
    
    private var sectionsData:[Int:[Episode]] = [:]
    
    init(data:Show) {
        super.init()
        self.data = data
        self.startRealmNotification()
    }
    
    func requestShowEpisodes() {
        RealmManager.share.getEpisodes(byShow: self.data) { (episodes, error) in }
    }
    
    func requestShowImage(){
        
        guard let url = URL(string: data.images["background"] ?? "") else {
            RealmManager.share.getImages(byShow: self.data) { (imageStringUrl, error) in }
            return
        }
        
        loadImage(from: url) { (image) in
            self.image = image
            self.notifyView(ofComponent: UIImageView())
        }
    }
    
    func stopRealmNotification(){
        self.notificationToken?.invalidate()
        self.notificationToken = nil
    }
    
    func startRealmNotification(){
        guard let realm = self.realm else {
            print("No Realm instance")
            return
        }
        
        
        self.notificationToken = self.data.observe { change in
            switch change {
                case .change(let show, let properties):
                    print(".change")
                    for property in properties {
                        if property.name == "images"{
                            self.requestShowImage()
                        }
                        if property.name == "episodes"{
                            self.notifyView(ofComponent: UITableView())
                        }
                    }
                case .error(let error):
                    print("An error occurred: \(error)")
                    self.notifyView(ofComponent: UIView(),error)
                // TODO: case .update()
                case .deleted:
                    print("The object was deleted.")

            }
        }
        
    }
    
    func notifyView(ofComponent:UIView,_ error:Error? = nil) {
        guard let delegate = self.delegate else{
            print("No delegate:ShowDetailViewModelDelegate set")
            return
        }
        delegate.didDataUpdate(self, onComponent: ofComponent, error)
    }
    
    func updateFavorite(){
        guard let realm = self.realm else {
            print("No Realm instance")
            return
        }
        
        try! realm.write{
            self.data.favourite.toggle()
        }
    }
    
}

extension ShowDetailViewModel: ShowDetailViewDataSource, UITableViewDataSource {
  
    func showDetailView(_ showDetailView: ShowDetailView, stringForTextComponent component: ShowDetailViewTextComponent) -> String? {
        switch component {
            case .name:
                return self.data.name
            case .rating:
                return "\(self.data.rating ?? 0.0)"
            case .gender:
                return self.data.genres.joined(separator: ", ")
            case .channel:
                return self.data.network
            case .time:
                return self.data.scheduleTime
            case .summary:
                return self.data.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
    }
    
    func showDetailView(_ showDetailView: ShowDetailView, imageForImageView imageView: UIImageView) -> UIImage? {
        return self.image
    }
    
    func showDetailView(_ showDetailView: ShowDetailView, enableDayWithLabel label: UILabel) -> Bool? {
        let prefixList = self.data.scheduleDays.map({$0.prefix(3)})
        guard let labelPrefix = label.text?.prefix(3) else { return nil}
        
        if prefixList.contains(labelPrefix){
            label.textColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2352941176, alpha: 1)
        }
        
        return prefixList.contains(labelPrefix)
    }
    
    func showDetailView(_ showDetailView: ShowDetailView, numberOfRowsForTable tableView: UITableView) -> Int {
        self.tableViewRows ?? 0
    }
    
    func showDetailView(_ showDetailView:ShowDetailView, numberOfSectionsForTable tableView:UITableView) -> Int {
        self.tableViewSections ?? 0
    }
    
    func showDetailView(_ showDetailView: ShowDetailView, statusForFavouriteButton button: UIButton) -> Bool {
        self.data.favourite
    }
    
}

extension ShowDetailViewModel{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.tableViewSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Seasson \(section+1)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realSection = section + 1
        self.sectionsData[realSection] = self.data.episodes.filter({$0.season == realSection})
        return self.sectionsData[realSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "EpisodeCellIdentifier")
   
        let episode = self.sectionsData[indexPath.section+1]![indexPath.row]
        cell.textLabel?.text = "\(episode.number). \(episode.name)"
        cell.detailTextLabel?.text = "\(episode.runtime) minutes"
        
        return cell
    }
    
    
}


