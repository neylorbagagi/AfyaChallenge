//
//  EpisodeDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 12/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    var episode:Episode?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var summary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let episode = self.episode{
            //configureView(withEpisode:episode)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func configureView(withEpisode episode:Episode) {
//
//        self.title = episode.name
//        self.name.text = episode.name
//        self.number.text = "Episode: \(episode.number)"
//        self.season.text = "Season: \(episode.season)"
//        self.summary.text = episode.summary
//
//        if let episodeImagePath = episode.image?.medium {
//            if let imageUrl = URL(string: episodeImagePath){
//                DispatchQueue.global().async {
//                    if let imageData = try? Data(contentsOf: imageUrl){
//                        if let episodePoster = UIImage(data: imageData){
//                            DispatchQueue.main.async {
//                                self.poster.image = episodePoster
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }

}
