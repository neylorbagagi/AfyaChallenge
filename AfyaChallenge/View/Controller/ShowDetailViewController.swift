//
//  NewShowDetailViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 24/09/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//


import UIKit

class ShowDetailViewController: UIViewController {

    var viewModel:ShowDetailViewModel?
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
        imageView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1)
        return imageView
    }()
    
    var imageActivityView:UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .gray)
        
        activityView.layer.cornerRadius = 6
        activityView.layer.masksToBounds = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        
        return activityView
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
        table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return table
    }()

    var tableActivityView:UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        
        return activityView
    }()
    
    var tableHeightConstraits = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.scrollView)
        
        guard let viewModel = self.viewModel else { return }
        
        self.headerView.delegate = self
        
        
        
        self.tableHeightConstraits = self.table.heightAnchor.constraint(equalToConstant: 0)
        self.table.addConstraint(self.tableHeightConstraits)
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.table.delegate = self
        self.table.dataSource = viewModel
        
        
        
        
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.imageActivityView)
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.summaryView)
        self.contentView.addSubview(self.scheduleView)
        self.contentView.addSubview(self.table)
        self.contentView.addSubview(self.tableActivityView)
        
        self.imageActivityView.startAnimating()
        self.tableActivityView.startAnimating()
        
        self.configure(viewModel: viewModel)
        
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
            
            self.imageActivityView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.imageActivityView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.imageActivityView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.imageActivityView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9/16),
            
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
            
            self.tableActivityView.topAnchor.constraint(equalTo: self.scheduleView.bottomAnchor, constant: 8),
            self.tableActivityView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            self.tableActivityView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            self.tableActivityView.heightAnchor.constraint(equalToConstant: 61)
        ])
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.requestImage()
        viewModel.requestEpisodes()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel = nil
    }
    
    deinit {
        print("deiniting")
    }
    
    func configure(viewModel:ShowDetailViewModel){
        
        self.headerView.nameLabel.text = viewModel.name
        self.headerView.ratingLabel.text = viewModel.rating
        self.headerView.favouriteButton.isSelected = viewModel.isFavourite
        
        self.summaryView.genderLabel.text = viewModel.genres
        self.summaryView.statusLabel.text = viewModel.status
        self.summaryView.textView.text = viewModel.summary
        
        self.scheduleView.networkLabel.text = viewModel.network
        
        if viewModel.time != ""{
            self.scheduleView.timeLabel.text = viewModel.time
        } else {
            self.scheduleView.timeLabel.isHidden = true
        }
        
        self.scheduleView.enableLabelDays(forDays: viewModel.scheduleDays)
        
        viewModel.bind = { image in
            DispatchQueue.main.async {
                self.imageActivityView.stopAnimating()
                self.imageView.image = image
            }
        }
          
        viewModel.bindEpisode = { rowsCount, seassonsCount in
            
            DispatchQueue.main.async {
                if rowsCount > 0 {
                    self.updateTableHeight(viewModel: viewModel)
                }
                self.tableActivityView.stopAnimating()
            }
        }
        
    }
    
    @objc func closeDetailView(){
        self.dismiss(animated: true, completion: nil)
    }

    
    func updateTableHeight(viewModel:ShowDetailViewModel){
        let tableHeight = viewModel.heightForTableView(rowCellHeight: self.table.rowHeight,
                                                       seassonViewHeight: self.table.sectionHeaderHeight)

        self.tableHeightConstraits.constant = tableHeight
        self.table.reloadData()
    }

}

extension ShowDetailViewController: HeaderViewDelegate {
    func headerView(_ headerView: HeaderView, favouriteButtonDidChanceTo status:Bool) {
        
        guard let viewModel = self.viewModel else { return }
        viewModel.updateFavouriteStatus()
    }
    
    
}

extension ShowDetailViewController: UITableViewDelegate {
    
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
