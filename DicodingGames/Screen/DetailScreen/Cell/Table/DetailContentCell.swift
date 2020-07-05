//
//  DetailContentCell.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit

class DetailContentCell: UITableViewCell {
    
    @IBOutlet weak var lblPlatform: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
