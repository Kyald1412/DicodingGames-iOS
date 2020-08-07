//
//  DetailSnapshotsContentCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import SDWebImage

class DetailSnapshotsContentCell: UICollectionViewCell {

    @IBOutlet weak var imgGame: UIImageView!
    
    func set(forScreenshots screenshotsData: ShortScreenshots) {
        let url = URL(string: screenshotsData.image ?? "")!
        
        imgGame.sd_imageIndicator = SDWebImageProgressIndicator.default
        let thumbnailSize = CGSize(width: 500, height: 500)
        imgGame?.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize: thumbnailSize])

    }
}
