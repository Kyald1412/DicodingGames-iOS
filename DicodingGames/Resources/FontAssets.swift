//
//  FontAssets.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

enum AssetsFont {
    case robotoBlack
    case robotoBold
    case robotoBoldItalic
    case robotoMedium
    case robotoMediumItalic
    case robotoRegular
}
extension UIFont {
    
    static func appFont(_ name: AssetsFont, size: CGFloat) -> UIFont? {
        switch name {
        case .robotoBlack:
            return UIFont.init(name: "Roboto-Black", size: size)
        case .robotoBold:
            return UIFont.init(name: "Roboto-Bold", size: size)
        case .robotoBoldItalic:
            return UIFont.init(name: "Roboto-BoldItalic", size: size)
        case .robotoMedium:
            return UIFont.init(name: "Roboto-Medium", size: size)
        case .robotoMediumItalic:
            return UIFont.init(name: "Roboto-MediumItalic", size: size)
        case .robotoRegular:
            return UIFont.init(name: "Roboto-Regular", size: size)
        }
    }
}
