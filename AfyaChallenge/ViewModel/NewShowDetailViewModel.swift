//
//  NewShowDetailViewModel.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 24/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import UIKit

class NewShowDetailViewModel: NSObject {
    
    private let data:Show
    let name:String
    let rating:String
    let isFavourite:Bool
    
    let genres:String
    let status:String
    let summary:String
    
    let network:String
    let time:String
    let scheduleDays:[String]
    
    var bindEpisode:((_ rows:Int,_ seassons:Int) -> Void)?
    var episodes:[Episode] {
        didSet {
            self.bindEpisode?(self.episodesCount,self.seassonsCount)
        }
    }
    
    var episodesCount:Int {
        return self.episodes.count
    }
    
    var seassonsCount:Int {
        var seasson = Set<Int>()
        for episode in self.episodes {
            seasson.insert(episode.season)
        }
        return seasson.count
    }
    
    private var sectionsData:[Int:[Episode]] = [:]
    
    
    var bind:((UIImage) -> Void)?
    var image:UIImage? {
        didSet {
            self.bind?(image ?? UIImage())
        }
    }
    
    init(data:Show) {
        self.data = data
        self.name = data.name
        self.network = data.network
        self.scheduleDays = Array(data.scheduleDays)
        self.rating = String(data.rating ?? 0.0)
        self.time = data.scheduleTime
        self.isFavourite = data.favourite
        self.genres = data.genres.joined(separator: ", ")
        self.status = data.status
        self.summary = data.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.episodes = Array(data.episodes)
    }
    
    func requestImage(){
        
        if let cachedImage = Cache.share.storage.object(forKey: data.images["background"] as AnyObject){
            self.image = cachedImage
            return
        }
        
        if let imageUrl = data.images["background"]{
            guard let url = URL(string: imageUrl) else {
                print("Invalid image url")
                return
            }
            loadImage(from: url) { (image) in
                guard let validImage = image else { return }
                Cache.share.storage.setObject(validImage, forKey: url.absoluteString as AnyObject)
                self.image = validImage
                return
            }
        }
        
        RealmManager.share.getImages(byShow: data) { (imageUrl, error) in
            guard let url = URL(string: imageUrl) else { return }
            loadImage(from: url) { (image) in
                guard let validImage = image else { return }
                Cache.share.storage.setObject(validImage, forKey: url.absoluteString as AnyObject)
                self.image = validImage
            }
        }
    }
    
    func requestEpisodes(){
        RealmManager.share.getEpisodes(byShow: self.data) { (episodes, error) in
            self.episodes = Array(episodes)
        }
    }
    
    func updateFavouriteStatus(){
        RealmManager.share.updateShowFavouriteStatus(show: self.data)
    }
    
    func heightForTableView(rowCellHeight:CGFloat, seassonViewHeight:CGFloat) -> CGFloat {
        let rowTotal = CGFloat(CGFloat(episodesCount) * rowCellHeight)
        let seassonTotal = CGFloat(CGFloat(seassonsCount) * seassonViewHeight)
        return rowTotal + seassonTotal + 32
    }
    
    public func selectedShow(_ indexPath:IndexPath) -> Episode {
        return self.sectionsData[indexPath.section+1]![indexPath.row]
    }
}

extension NewShowDetailViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.seassonsCount
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
