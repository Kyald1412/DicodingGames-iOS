//
//  FavoriteRow.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 16/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine
import SDWebImage
import UIKit


struct FavoriteRow: UIViewRepresentable {
    
    let games: FavoriteGames
    
    func makeUIView(context: Context) -> UIView {
    
        let view: UIView = UIView()
        view.frame = CGRect(x: 0, y: 0, width: .max, height: 170)
        view.backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
        let imgGame: UIImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 130, height: 170))
        
        let url = URL(string: games.game_img_url)
        imgGame.sd_imageIndicator = SDWebImageProgressIndicator.default;
        let thumbnailSize = CGSize(width: 500, height: 500) // Thumbnail will bounds to (200,200)
        imgGame.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
        
//        imgGame.image = UIImage.init(named: "placeholder_gta")
        imgGame.contentMode = .scaleAspectFill
        imgGame.clipsToBounds = true
        
        view.addSubview(imgGame)
        
        
        //Title View
        let lblTitle: UILabel = UILabel.init()
        lblTitle.text = games.game_title
        lblTitle.numberOfLines = 2
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.minimumScaleFactor = 0.5
        lblTitle.textColor = UIColor.white
        lblTitle.font = UIFont.appFont(.ProximaNova_Bold, size: 20)
        
        view.addSubview(lblTitle)
        
        //Date View
        let lblDate: UILabel = UILabel.init()
        lblDate.text = games.game_release_date
        lblDate.textColor = UIColor.white
        lblDate.font = UIFont.appFont(.ProximaNova_Regular, size: 14)

        view.addSubview(lblDate)
        
        //Desc View
        let lblDesc: UILabel = UILabel.init()
        lblDesc.text = games.game_desc
        lblDesc.textColor = UIColor.white
        lblDesc.numberOfLines = 4
        lblDesc.textAlignment = .justified
        lblDesc.lineBreakMode = .byTruncatingTail
        lblDesc.font = UIFont.appFont(.ProximaNova_Regular, size: 14)
        view.addSubview(lblDesc)
        
        //Star View
        let icStar: UIImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        icStar.image = UIImage.init(named: "ic_star")
        icStar.contentMode = .scaleAspectFit
        icStar.clipsToBounds = true
        
        view.addSubview(icStar)
        
        //Rating View
        let lblRating: UILabel = UILabel.init()
        lblRating.text = games.game_ratings
        lblRating.textColor = UIColor.white
        lblRating.font = UIFont.appFont(.ProximaNova_Bold, size: 14)

        view.addSubview(lblRating)
        
        
        
        
        // Title Constraint
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: lblTitle, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imgGame, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: lblTitle, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: lblTitle, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -16).isActive = true
        
        
        // Date Constraint
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: lblDate, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imgGame, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: lblDate, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lblTitle, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: lblDate, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -16).isActive = true
        
        
        // Desc Constraint
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: lblDesc, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imgGame, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: lblDesc, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lblDate, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: lblDesc, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -16).isActive = true
        
        
        // Icon Constraint
        icStar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: icStar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imgGame, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 12).isActive = true
        NSLayoutConstraint(item: icStar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lblDesc, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: icStar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: icStar, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 30).isActive = true
        
        // Rating Constraint
        lblRating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: lblRating, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: icStar, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: lblRating, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: icStar, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: lblRating, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -16).isActive = true
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}


struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
      
        return FavoriteRow(games: FavoriteGames())
    }
}
