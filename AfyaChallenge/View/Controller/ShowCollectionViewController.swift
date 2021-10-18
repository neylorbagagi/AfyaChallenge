//
//  ShowCollectionViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO: MAKE UICollectionViewDelegateFlowLayout smarter
///TODO: FIX "negative sizes are not supported in the flow layout"

class ShowCollectionViewController: UIViewController {

    var viewModel:ShowCollectionViewModel?
    var isListeningScrollView:Bool = false
    
    var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCollectionCell")
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //collectionView.bounces = false
        return collectionView
    }()
    
    var navigationBar:UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.isTranslucent = false
        return navigationBar
    }()
    
    var searchResult:SearchViewController = {
        let searchResult = SearchViewController()
        return searchResult
    }()
    
    var searchButton:UIBarButtonItem = {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: #selector(presentSearchViewController))
        searchButton.tintColor = #colorLiteral(red: 0.1369999945, green: 0.1369999945, blue: 0.1369999945, alpha: 1)
        return searchButton
    }()
    
    var imageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.viewModel = ShowCollectionViewModel()
        
        self.viewModel?.dataBind = {
            self.isListeningScrollView = true
            self.collectionView.reloadData()
        }
        
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self

        let navigationItem = UINavigationItem()
        navigationItem.rightBarButtonItem = self.searchButton
        navigationItem.titleView = self.imageView
        
        self.navigationBar.setItems([navigationItem], animated: true)
        
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.navigationBar.heightAnchor.constraint(equalToConstant: 44),

            self.imageView.heightAnchor.constraint(equalToConstant: 34),
            
            self.collectionView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.viewModel?.notificationToken == nil{
            self.viewModel?.startRealmNotification()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel?.stopRealmNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func presentSearchViewController(){
        let resultsViewController = SearchViewController()
        resultsViewController.viewModel = SearchViewModel()
        self.present(resultsViewController, animated: true,completion: nil)
    }
      
}

extension ShowCollectionViewController:UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeightSize:CGFloat = scrollView.frame.size.height
        let scrollViewContentSize:CGFloat = scrollView.contentSize.height
        let scrollViewPosition = scrollViewContentSize-scrollViewHeightSize
        let contentOffsetY = scrollView.contentOffset.y
        
        if  scrollViewContentSize > 0 &&
            self.isListeningScrollView == true &&
            contentOffsetY > scrollViewPosition{
            self.isListeningScrollView = false
            self.viewModel?.requestData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = ShowDetailViewController()
        let show = self.viewModel?.selectedShowForSegue(indexPath)
        let detailViewModel = ShowDetailViewModel(data: show!)
        detailViewController.viewModel = detailViewModel
        self.present(detailViewController, animated: true,completion: nil)
    }
    
}

extension ShowCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    private var sectionInsets:UIEdgeInsets { return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6) }
    private var itemsPerRow:CGFloat { return 3 }
    private var itemsPerColumn: CGFloat { return 4}
    private var itemsOriginalWidth:CGFloat { return 210 } /// Using the original size of the poster
    private var itemsOriginalHeight:CGFloat { return 295 } /// Using the original size of the poster
    private var footerInSectionSize:CGFloat { return 75 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.contentSize.width - 8
        
        /// Calculate width
        let widthPaddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
        let widthAvailable = collectionWidth - widthPaddingSpace
        let widthForItem = widthAvailable/self.itemsPerRow
        
        /// Calculate height proportion by its width
        /// Formula (original height / original width) x new width = new height
        let heightForItem = (self.itemsOriginalHeight/self.itemsOriginalWidth)*widthForItem
        return CGSize(width: widthForItem, height: heightForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.footerInSectionSize)
    }
    
    
}


