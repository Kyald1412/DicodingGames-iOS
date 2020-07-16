//
//  HomeBannerCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomeBannerCell: UITableViewCell {

    @IBOutlet weak var viewSlider: ImageSlideshow!
    @IBOutlet weak var indicator: UIPageControl!
    
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var icFavorite: UIButton!
    
    let gradientLayer = CAGradientLayer()

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = viewGradient.bounds
        gradientLayer.colors = [UIColor.clear,UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        viewGradient.layer.addSublayer(gradientLayer)
    }
    
}
