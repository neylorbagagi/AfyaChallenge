//
//  ShowCollectionViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

class ShowCollectionViewController: UICollectionViewController, ShowCollectionViewModelDelegate {

    var viewModel:ShowCollectionViewModel?
    var isListeningScrollView:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCollectionCells(collection: self.collectionView!)
        
        self.viewModel = ShowCollectionViewModel()
        self.viewModel?.delegate = self
        
        self.collectionView?.dataSource = self.viewModel
        self.collectionView?.bounces = false
        
        self.viewModel?.requestData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.registerForSearchDelegate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForSearchDelegate(){
        guard self.navigationController != nil else{
            print("No Navigation Controller set")
            return
        }
        
        let navigationController = self.navigationController as! MainNavigationController
        navigationController.searchBar?.delegate = self
    }
    
    func registerCollectionCells(collection:UICollectionView){
        collection.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCollectionCell")
        collection.register(SearchCollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                            withReuseIdentifier: "searchCollectionHeader")
    }

    func didDataUpdate(_ viewModel: ShowCollectionViewModel, data:[Show], _ collectionMode:ShowCollectionMode, _ error: Error?) {
        
        guard error == nil else {
            print(error.debugDescription)
            self.isListeningScrollView = true
            return
        }
        
        self.collectionView?.reloadData()
        self.isListeningScrollView = true
    }
      
}

extension ShowCollectionViewController{
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    
}

extension ShowCollectionViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isListeningScrollView = false
        self.viewModel?.switchCollectionMode(to: .search)
        self.collectionView?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.requestData(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.viewModel?.switchCollectionMode(to: .page)
        self.collectionView?.reloadData()
        self.isListeningScrollView = true
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
        
        let collectionWidth = collectionView.frame.width
        
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
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 51)
//    }
    
}


