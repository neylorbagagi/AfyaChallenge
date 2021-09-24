//
//  ShowTableViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 26/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO: IMPLEMENT CONSTRAITS UPDATE FOR COLLECTIONVIEW
///TODO: THIS VIEW SHOULD NOT TO KNOW sectionType make it came from VIEWMODEL

protocol ShowTableViewCellDelegate {
    func tableViewCell(_ tableViewCell:UITableViewCell, modelView:ShowTableViewModel, didSelectItemAt indexPath:IndexPath)
}

class ShowTableViewCell: UITableViewCell {

    var viewModel:ShowTableViewModel?
    var collectionView:UICollectionView?
    var sectionTitle:UILabel?
    var sectionEmptyLabel:UILabel?
    var sectionType:HomeTableViewSection?
    var container:UIView?
    var collectionViewHeight:NSLayoutConstraint?
    
    var delegate:ShowTableViewCellDelegate?
    
    override func updateConstraints() {
        if needsUpdateConstraints() {
            self.settupCollectionConstraints(to: self.container!, related: self.sectionTitle!)
            self.settupContainerViewConstraints(to: self)
            self.collectionView?.reloadData()
        }
        
        
        super.updateConstraints()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        self.selectionStyle = .none
        self.configureContainerView(to: self)
        self.configureSectionTitle(to: self.container!)
        self.configureCollectionView(to: self.container!, related: self.sectionTitle!)
        self.configureCollectionLabel(to: self.container!, related: self.sectionTitle!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContainerView(to view:UIView){
        self.container = UIView()
        self.container?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.container!)
        self.settupContainerViewConstraints(to: view)
    }
    
    func configureSectionTitle(to view:UIView){
        self.sectionTitle = UILabel()
        self.sectionTitle?.font = self.sectionTitle?.font.withSize(36)
        self.sectionTitle?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.sectionTitle!)
        
        self.sectionTitle?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        self.sectionTitle?.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        self.sectionTitle?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        self.sectionTitle?.heightAnchor.constraint(equalToConstant: 61).isActive = true
    }
    
    func configureCollectionView(to view:UIView, related label:UILabel) {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionViewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: flowLayout)
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCell")
        self.collectionView?.register(HighlightCollectionViewCell.self, forCellWithReuseIdentifier: "highlightCell")
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.dataSource = self.viewModel
        self.collectionView?.delegate = self
        
        view.addSubview(self.collectionView!)
        self.settupCollectionConstraints(to: view, related: label)
    }
    
    func configureCollectionLabel(to view:UIView, related label:UILabel){
        self.sectionEmptyLabel = UILabel()
        //self.sectionEmptyLabel?.font = self.sectionTitle?.font.withSize(36)
        self.sectionEmptyLabel?.text = "No Shows for this section  :[ "
        self.sectionEmptyLabel?.textAlignment = .center
        self.sectionEmptyLabel?.isHidden = true
        self.sectionEmptyLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.sectionEmptyLabel!)
        self.settupCollectionLabelConstraints(to: view, related: label)
    }
    
    func settupCollectionLabelConstraints(to view:UIView, related label:UILabel){

        self.sectionEmptyLabel?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        self.sectionEmptyLabel?.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        self.sectionEmptyLabel?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        self.sectionEmptyLabel?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }
    
    func settupContainerViewConstraints(to view:UIView){
        
        self.container?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.container?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.container?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.container?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func settupCollectionConstraints(to view:UIView, related label:UILabel){
        
        if self.collectionViewHeight == nil {
            self.collectionViewHeight = self.collectionView?.heightAnchor.constraint(equalToConstant: 194.619)
        }
        self.collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.collectionView?.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        self.collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.collectionView?.heightAnchor.constraint(equalToConstant: self.collectionViewHeight?.constant ?? 110).isActive = true
    }
    
    func bindingFrom(_ viewModel:ShowTableViewModel){
        self.viewModel = viewModel
        self.sectionTitle?.text = viewModel.sectionTitle
        self.sectionType = viewModel.sectionType
        self.collectionView?.dataSource = viewModel
        viewModel.bind = { (data) in
            self.sectionEmptyLabel?.isHidden = data.count == 0 ? false : true
            self.collectionView?.reloadData()
        }
        viewModel.requestData()
    }
    
}

extension ShowTableViewCell: UICollectionViewDelegateFlowLayout{
    
    private var sectionInsets:UIEdgeInsets { return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6) }
    private var itemsPerRow:CGFloat {
        switch self.sectionType {
        case .highlights:
            return 1.3
        default:
            return 3
        }
    }
    
    private var itemsPerColumn: CGFloat {
        switch self.sectionType {
        case .highlights:
            return 1
        default:
            return 4
        }
    }
    
    private var itemsOriginalWidth:CGFloat {
        switch self.sectionType {
        case .highlights:
            return 1920
        default:
            return 210
        }
    } /// Using the original size of the poster
    
    private var itemsOriginalHeight:CGFloat {
        switch self.sectionType {
        case .highlights:
            return 1080
        default:
            return 295
        }
    } /// Using the original size of the poster
    
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
        
        // self.collectionViewHeight? = (self.collectionView?.heightAnchor.constraint(equalToConstant: heightForItem+sectionInsets.top+sectionInsets.bottom))!
        // self.collectionView?.setNeedsUpdateConstraints()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.top
    }


}

extension ShowTableViewCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print(indexPath.row)
        
        guard let delegate = self.delegate,
              let viewModel = self.viewModel else {
            print("Not delegate set")
            return
        }
        delegate.tableViewCell(self, modelView: viewModel, didSelectItemAt: indexPath)
        
    }
    
}
