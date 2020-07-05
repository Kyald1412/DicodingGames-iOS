//
//  HomeGameCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: HomeGameContentCell?, index: Int, didTappedInTableViewCell: HomeGameCell)    
}

class HomeGameCell: UITableViewCell {
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var rowGames: [Results]?
    var cellIdentifier: String = ""
    
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 240)
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.minimumInteritemSpacing = 20.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "HomeGameContentCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "HomeGameContentCell")
    }
}

extension HomeGameCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [Results]) {
        self.rowGames = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeGameContentCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowGames?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeGameContentCell", for: indexPath) as? HomeGameContentCell {

            if let gameData = self.rowGames?[indexPath.item] {
              cell.set(forGames: gameData)
            }

            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
