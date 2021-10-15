//
//  SearchResultsViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 10/10/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

///TODO: figure out how to init with required viewModel

import UIKit

class SearchViewController: UIViewController {

    var viewModel:SearchViewModel?
    
    var searchBar:UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        searchBar.tintColor = #colorLiteral(red: 0.8270000219, green: 0.1099999994, blue: 0.3569999933, alpha: 1)
        searchBar.placeholder = "Search for Shows"
        return searchBar
    }()
    
    var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCollectionCell")
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = self.viewModel else { return }
        
        self.view.backgroundColor = .white
        
        
        
        self.searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
        
        viewModel.bind = {
            self.collectionView.reloadData()
        }
        
        self.collectionView.dataSource = viewModel
        self.collectionView.delegate = self
        
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.requestData(searchString: searchText)
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = ShowDetailViewController()
        let show = self.viewModel?.selectedShow(indexPath)
        let detailViewModel = ShowDetailViewModel(data: show!)
        detailViewController.viewModel = detailViewModel
        detailViewController.modalPresentationStyle = .currentContext
        self.present(detailViewController, animated: true,completion: nil)
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    
    private var sectionInsets:UIEdgeInsets { return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6) }
    private var itemsPerRow:CGFloat { return 3 }
    private var itemsPerColumn: CGFloat { return 4}
    private var itemsOriginalWidth:CGFloat { return 210 } /// Using the original size of the poster
    private var itemsOriginalHeight:CGFloat { return 295 } /// Using the original size of the poster
    private var footerInSectionSize:CGFloat { return 75 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.frame.width - 8
        
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
