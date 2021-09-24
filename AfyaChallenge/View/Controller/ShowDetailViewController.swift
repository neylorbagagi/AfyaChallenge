//
//  ShowDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    var viewModel:ShowDetailViewModel?
    var showDetailView:ShowDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showDetailView = self.view as? ShowDetailView
        self.showDetailView?.delegate = self
        self.showDetailView?.modelView = self.viewModel
        
        self.showDetailView?.reloadData()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueEpisodeDetail"{
            
            guard let indexPath:IndexPath = sender as? IndexPath else {
                print("Invalid Index")
                return
            }
            
            if let detailView = segue.destination as? EpisodeDetailViewController {
                
                let episode:Episode = (self.viewModel?.selectedShowForSegue(indexPath))!
                let detailViewModel = EpisodeDetailViewModel(data:episode)
                
                detailView.viewModel = detailViewModel
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.showDetailView?.modelView?.stopRealmNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Tcharaamm")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ShowDetailViewController: ShowDetailViewDelegate {
    func showDetailView(_ showDetailView: ShowDetailView, didSelectedEpisodeAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueEpisodeDetail", sender: indexPath)
    }
    
}

