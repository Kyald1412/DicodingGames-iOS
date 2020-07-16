//
//  DetailSnapshotsCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit

protocol DetailSnapshotDelegate: class {
    func collectionView(collectionviewcell: DetailSnapshotsContentCell?, index: Int, didTappedInTableViewCell: DetailSnapshotsCell)
}

class DetailSnapshotsCell: UITableViewCell {
    
    weak var cellDelegate: DetailSnapshotDelegate?
    
    var rowScreenshots: [ShortScreenshots]?
    var cellIdentifier: String = ""
    
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 280, height: 140)
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.minimumInteritemSpacing = 20.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "DetailSnapshotsContentCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "DetailSnapshotsContentCell")
    }
}

extension DetailSnapshotsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: GameDetailScreenshots) {
        self.rowScreenshots = row.results
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DetailSnapshotsContentCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowScreenshots?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailSnapshotsContentCell", for: indexPath) as? DetailSnapshotsContentCell {
            
            if let screenshotsData = self.rowScreenshots?[indexPath.item] {
                cell.set(forScreenshots: screenshotsData)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
