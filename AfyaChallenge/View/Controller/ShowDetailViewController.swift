//
//  ShowDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    var show:Show?
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var schedule: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var summary: UITextView!
    private var isRequestingData:Bool = false
    
    @IBOutlet weak var episodesTable: UITableView!
    private let reuseIdentifier = "EpisodeCellIdentifier"
    var episodesDataCache:[Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.episodesTable.delegate = self
        self.episodesTable.dataSource = self
        
        // Do any additional setup after loading the view.
        if let show = self.show{
            self.requestData(show: show.id)
            configureView(withShow:show)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestData(show id:Int){
        self.isRequestingData = true
        
//        APIClient.shared.getEpisodes(forShow: id) { (data, error) in
//            guard error == nil else {
//                print(error.debugDescription)
//                self.isRequestingData = false
//                return
//            }
//
//            self.episodesDataCache = data
//            DispatchQueue.main.async {
//                self.episodesTable.reloadData()
//                self.isRequestingData = false
//            }
//        }
        
    }

    func configureView(withShow show:Show) {
        
        self.title = show.name
        self.name.text = show.name
        //self.schedule.text = show.schedule.days.debugDescription+" "+show.schedule.time
        self.genres.text = show.genres.description
        self.summary.text = show.summary
        
//        if let showImagePath = show.image?.medium {
//            if let imageUrl = URL(string: showImagePath){
//                DispatchQueue.global().async {
//                    if let imageData = try? Data(contentsOf: imageUrl){
//                        if let showPoster = UIImage(data: imageData){
//                            DispatchQueue.main.async {
//                                self.poster.image = showPoster
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }

    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowEpisodeDetail"{
//
//            guard let indexPathSelected = self.episodesTable?.indexPathForSelectedRow else {
//                print("error indexpath")
//                return
//            }
//
//            if let detailVC = segue.destination as? EpisodeDetailViewController {
//                let sectionEpisodes = self.episodesDataCache.filter({$0.season == indexPathSelected.section+1})
//                detailVC.episode = sectionEpisodes[indexPathSelected.row]
//            }
//        }
//    }
}

extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        return cell
    }
    
    
    
//    // MARK: UITableViewDataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        let dict = Dictionary(grouping: self.episodesDataCache, by: {$0.season})
//        return dict.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Season \(section+1)"
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.episodesDataCache.filter({$0.season == section+1}).count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
//
//        let episodesForSection = self.episodesDataCache.filter({$0.season == indexPath.section+1})
//        let episode = episodesForSection[indexPath.row]
//
//        cell.textLabel?.text = episode.name
//
//        return cell
//
//    }
//
//    // MARK: UITableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // calls by itself prepareForSegue
//    }
    
}
