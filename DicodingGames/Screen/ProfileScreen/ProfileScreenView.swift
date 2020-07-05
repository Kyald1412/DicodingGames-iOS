//
//  ProfileScreenView.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import PKHUD
import Closures

class ProfileScreenView: UIViewController {
    
    var presenter: ProfileScreenPresenterProtocol?
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 50.0, right: 20.0)
    
    private var isListView = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileScreenView: ProfileScreenViewProtocol {
    
}


// MARK: - UICollectionViewDataSource
extension ProfileScreenView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return academies.count
        
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isListView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProfileAcademyCellList", for: indexPath) as? ProfileAcademyCellList
                else {
                    preconditionFailure("Invalid cell type")
            }
            
            cell.imageView.image =  UIImage.init(named:academies[indexPath.row].photo)
            cell.title.text = academies[indexPath.row].name
            
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProfileAcademyCell", for: indexPath) as? ProfileAcademyCell
                else {
                    preconditionFailure("Invalid cell type")
            }
            
            cell.imageView.image =  UIImage.init(named:academies[indexPath.row].photo)
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "\(ProfileHeaderCell.self)",
                for: indexPath) as? ProfileHeaderCell
                else {
                    fatalError("Invalid view type")
            }
            
            headerView.imgList.addTapGesture { (tap) in
                self.isListView = true
                
                UIView.transition(with: self.collectionView,
                duration: 0.35,
                options: .curveEaseInOut,
                animations: { self.collectionView.reloadData() }) // left out the unnecessary syntax in the completion block and the optional completion parameter

                
            }
            
            headerView.imgGrid.addTapGesture { (tap) in
                self.isListView = false
                UIView.transition(with: self.collectionView,
                              duration: 0.35,
                              options: .curveEaseInOut,
                              animations: { self.collectionView.reloadData() }) // le
            }
            
            
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileScreenView: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if isListView {
            let width = view.frame.width
            return CGSize(width: width, height: 160)
        }else {
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            
            return CGSize(width: widthPerItem, height: widthPerItem)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if isListView {
            return UIEdgeInsets.init()
        } else {
            return sectionInsets
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isListView {
            return 20
        } else {
            return sectionInsets.left
        }
    }
}

