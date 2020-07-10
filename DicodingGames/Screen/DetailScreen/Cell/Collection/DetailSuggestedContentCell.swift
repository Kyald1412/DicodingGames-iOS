//
//  DetailSuggestedContentCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import SDWebImage

class DetailSuggestedContentCell: UICollectionViewCell {

    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    func set(forGame gameData: Results) {
        let url = URL(string: gameData.backgroundImage)!
        
        lblTitle.text = gameData.name
        imgGame.sd_imageIndicator = SDWebImageProgressIndicator.default;
        let thumbnailSize = CGSize(width: 500, height: 500)
        imgGame?.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])

    }
}
