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
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var close: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }
        self.configure(viewModel: viewModel)
        
        self.close.addTarget(self, action: #selector(closeDetail), for: .touchDown)
    }

    func configure(viewModel:EpisodeDetailViewModel){
        self.name.text = viewModel.name
        self.duration.text = viewModel.duration
        self.season.text = viewModel.season
        self.summary.text = viewModel.summary
        
        viewModel.bind = { image in
            DispatchQueue.main.async {
                self.poster.image = image
            }
        }
        viewModel.requestEpisodeImage()
    }
    
    @objc func closeDetail(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
