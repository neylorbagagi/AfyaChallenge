//
//  NewShowDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 24/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//


///TODO: UPDATE DATA auto
///TODO: verify if is saving episodes
///TODO: the highlight request is over writing the favourite attribute
///TODO: tableHeight wrong calculation

import UIKit

class NewShowDetailViewController: UIViewController {

    var viewModel:NewShowDetailViewModel?
    private let reuseIdentifier = "EpisodeCellIdentifier"
    
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
    
    var headerView:HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
   
    var summaryView:SummaryView = {
        let summaryView = SummaryView()
        summaryView.layer.cornerRadius = 6
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        return summaryView
    }()
    
    var scheduleView:ScheduleView = {
        let scheduleView = ScheduleView()
        scheduleView.layer.cornerRadius = 6
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        scheduleView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        return scheduleView
    }()
    
    var table:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        table.sectionHeaderHeight = 30
        table.rowHeight = 51
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        guard let viewModel = self.viewModel else { return }
        
        self.headerView.delegate = self
        
        self.configure(viewModel: viewModel)


        self.table.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.table.delegate = self
        self.table.dataSource = viewModel
        
        
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.summaryView)
        self.contentView.addSubview(self.scheduleView)
        self.contentView.addSubview(self.table)
        
        NSLayoutConstraint.activate([
            
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            self.closeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                        
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
            
            self.headerView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            self.headerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.headerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.headerView.heightAnchor.constraint(equalToConstant: 61),
            
            self.summaryView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 8),
            self.summaryView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.summaryView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.scheduleView.topAnchor.constraint(equalTo: self.summaryView.bottomAnchor, constant: 8),
            self.scheduleView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.scheduleView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.table.topAnchor.constraint(equalTo: self.scheduleView.bottomAnchor, constant: 8),
            self.table.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            self.table.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            self.table.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.table.heightAnchor.constraint(equalToConstant: 0)
        ])
        
        
    }

    func configure(viewModel:NewShowDetailViewModel){
        
        viewModel.bind = { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        viewModel.requestImage()
        
        viewModel.bindEpisode = { rowsCount, seassonsCount in
            DispatchQueue.main.async {
                self.updateTableHeight(viewModel: viewModel)
            }
        }
        
        if viewModel.episodes.count > 0 {
            DispatchQueue.main.async {
                self.updateTableHeight(viewModel: viewModel)
            }
        } else {
            viewModel.requestEpisodes()
        }
        
        self.headerView.nameLabel.text = viewModel.name
        self.headerView.ratingLabel.text = viewModel.rating
        self.headerView.favouriteButton.isSelected = viewModel.isFavourite
        
        self.summaryView.genderLabel.text = viewModel.genres
        self.summaryView.statusLabel.text = viewModel.status
        self.summaryView.textView.text = viewModel.summary
        
        self.scheduleView.networkLabel.text = viewModel.network
        self.scheduleView.timeLabel.text = viewModel.time
        self.scheduleView.enableLabelDays(forDays: viewModel.scheduleDays)
        
    }
    
    @objc func closeDetailView(){
        self.dismiss(animated: true, completion: nil)
    }

    
    func updateFavorite(){
        
    }
    
    func updateTableHeight(viewModel:NewShowDetailViewModel){
        let tableHeight = viewModel.heightForTableView(rowCellHeight: self.table.rowHeight,
                                                       seassonViewHeight: self.table.sectionHeaderHeight)
        let constrait = self.table.constraints.filter{$0.firstAttribute == .height}.first
        constrait?.constant = tableHeight
    }

}

extension NewShowDetailViewController: HeaderViewDelegate {
    func headerView(_ headerView: HeaderView, favouriteButtonDidChanceTo status:Bool) {
        
        guard let viewModel = self.viewModel else { return }
        viewModel.updateFavouriteStatus()
    }
    
    
}

extension NewShowDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        
        let episodeViewController = EpisodeDetailViewController()
        let show = viewModel.selectedShow(indexPath)
        let episodeViewModel = EpisodeDetailViewModel(data: show)
        episodeViewController.viewModel = episodeViewModel
        self.present(episodeViewController, animated: true,completion: nil)
        
//        let detailViewController = NewShowDetailViewController()
//        let show = modelView.data[indexPath.row]
//        let detailViewModel = NewShowDetailViewModel(data: show)
//        detailViewController.viewModel = detailViewModel
//        self.present(detailViewController, animated: true,completion: nil)
        
    }
    
}
