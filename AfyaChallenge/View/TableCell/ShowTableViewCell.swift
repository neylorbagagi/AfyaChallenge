//
//  ShowTableViewCell.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 26/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import UIKit

///TODO: THIS VIEW SHOULD NOT TO KNOW sectionType make it came from VIEWMODEL

protocol ShowTableViewCellDelegate {
    func tableViewCell(_ tableViewCell:UITableViewCell, modelView:ShowTableViewModel, didSelectItemAt indexPath:IndexPath)
}

class ShowTableViewCell: UITableViewCell {

    var viewModel:ShowTableViewModel?
    var sectionType:HomeTableViewSection?
    
    var delegate:ShowTableViewCellDelegate?
    
    var collectionViewHeight:NSLayoutConstraint?
    var containerViewHeight:NSLayoutConstraint?
    
    
    // O U T L E T S
    var container:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var sectionTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Bold", size: 36)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "showCell")
        collectionView.register(HighlightCollectionViewCell.self, forCellWithReuseIdentifier: "highlightCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var sectionEmptyLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "No Shows for this section yet :["
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Thin", size: 22)
        label.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        self.selectionStyle = .none
        
        self.collectionView.dataSource = self.viewModel
        self.collectionView.delegate = self
        
        self.addSubview(self.container)
        self.container.addSubview(self.sectionTitle)
        self.container.addSubview(self.collectionView)
        self.container.addSubview(self.sectionEmptyLabel)
        
        self.collectionViewHeight = self.collectionView.heightAnchor.constraint(equalToConstant: 180)
        self.collectionView.addConstraint(self.collectionViewHeight!)
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.container.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.sectionTitle.topAnchor.constraint(equalTo: self.container.topAnchor),
            self.sectionTitle.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 16),
            
            self.collectionView.topAnchor.constraint(equalTo: self.sectionTitle.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 10),
            self.collectionView.rightAnchor.constraint(equalTo: self.container.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
            
            self.sectionEmptyLabel.topAnchor.constraint(equalTo: self.sectionTitle.bottomAnchor),
            self.sectionEmptyLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor),
            self.sectionEmptyLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor),
            self.sectionEmptyLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
            self.sectionEmptyLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindingFrom(_ viewModel:ShowTableViewModel){
        self.viewModel = viewModel
        self.sectionTitle.text = viewModel.sectionTitle
        self.sectionType = viewModel.sectionType
        self.collectionView.dataSource = viewModel
        viewModel.bind = { (data) in
            self.sectionEmptyLabel.isHidden = data.count == 0 ? false : true
            self.collectionView.reloadData()
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
        
        self.collectionViewHeight?.constant = heightForItem
        
        return CGSize(width: widthForItem, height: heightForItem)
        
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
