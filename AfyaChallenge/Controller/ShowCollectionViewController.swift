//
//  ShowCollectionViewController.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 11/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit



class ShowCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "ShowCellIdentifier"
    private var dataCache:[ACShow] = []
    private var imageCache:[Int:UIImage] = [:]
    private var pageOffset:Int = 0
    private var isRequestingData:Bool = false
    
    // UICollectionViewDelegateFlowLayout Params
    private let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private let itemsPerRow: CGFloat = 3
    private let itemsPerColumn: CGFloat = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For the sek of the clearness I'm using requestData()
        self.requestData(page: self.pageOffset)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
            
            guard let indexPathList = collectionView?.indexPathsForSelectedItems else {
                print("error indexpath")
                return
            }

            let localIndexPath:IndexPath = indexPathList[0]
            if let detailVC = segue.destination as? ShowDetailViewController {
                detailVC.show = self.dataCache[localIndexPath.row]
            }
        }
    }
    
    
    func requestData(page:Int){
        self.isRequestingData = true
        APIClient.shared.getShows(forPage: page) { (data, error) in
            guard error == nil else {
                print(error.debugDescription)
                self.isRequestingData = false
                return
            }
            self.pageOffset += 1
            self.dataCache = self.dataCache + data
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.isRequestingData = false
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCache.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ShowCollectionViewCell
        
        let show = self.dataCache[indexPath.row]
        
        // Configure the cell
        cell.name.text = show.name
        cell.image.image = UIImage()
        
        
        // TODO: Put it on a func
        if let showImagePath = show.image?.medium {
            
            if let image = self.imageCache[show.id]{
                cell.image.image = image
            } else{
                if let imageUrl = URL(string: showImagePath){
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl){
                            if let showPoster = UIImage(data: imageData){
                                self.imageCache[show.id] = showPoster
                                DispatchQueue.main.async {
                                    cell.image.image = showPoster
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // calls by itself prepareForSegue
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// We don't want that requests takes to long, so I will call for ever page when user reachs de scrollView bottom
        let scrollViewHeightSize:CGFloat = scrollView.frame.size.height
        let scrollViewContentSize:CGFloat = scrollView.contentSize.height
        let scrollViewPosition = scrollViewContentSize-scrollViewHeightSize
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > scrollViewPosition && self.isRequestingData == false{
            requestData(page:self.pageOffset)
        }
    }


}

// MARK: UICollectionViewDelegate
extension ShowCollectionViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //TODO: Verify 'view.frame.width' maybe this can change in other devices
        let widthPaddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
        let widthAvailable = view.frame.width - widthPaddingSpace
        let widthForItem = widthAvailable/self.itemsPerRow
        
        let heightPaddingSpace = self.sectionInsets.top * (self.itemsPerColumn + 1)
        let heightAvailable = view.frame.height - heightPaddingSpace
        let heightForItem = heightAvailable/self.itemsPerColumn
        return CGSize(width: widthForItem, height: heightForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 75)
    }
}
