//
//  HomeGameContentCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import SDWebImage

class HomeGameContentCell: UICollectionViewCell {

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblGame: UILabel!
    @IBOutlet weak var imgGame: UIImageView!

    func set(forGames games: Results) {
        lblRating?.text = "\(games.ratingBuilder)"
        lblGame?.text = games.name
            
        let url = URL(string: games.backgroundImage)
        imgGame.sd_imageIndicator = SDWebImageProgressIndicator.default;
        let thumbnailSize = CGSize(width: 500, height: 500) // Thumbnail will bounds to (200,200)
        imgGame?.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])

    }
}
