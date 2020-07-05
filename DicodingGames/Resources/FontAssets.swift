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
    case ProximaNova_Extrabold
    case ProximaNova_Light
    case ProximaNova_Black
    case ProximaNova_Semibold
    case ProximaNova_Bold
    case ProximaNova_Regular
    case Roboto_Black
    case Roboto_Bold
    case Roboto_BoldItalic
    case Roboto_Medium
    case Roboto_MediumItalic
    case Roboto_Regular
}
extension UIFont {
    
    static func appFont(_ name: AssetsFont, size: CGFloat) -> UIFont? {
        switch name {
        case .Roboto_Black:
            return UIFont.init(name: "Roboto-Black", size: size)
        case .Roboto_Bold:
            return UIFont.init(name: "Roboto-Bold", size: size)
        case .Roboto_BoldItalic:
            return UIFont.init(name: "Roboto-BoldItalic", size: size)
        case .Roboto_Medium:
            return UIFont.init(name: "Roboto-Medium", size: size)
        case .Roboto_MediumItalic:
            return UIFont.init(name: "Roboto-MediumItalic", size: size)
        case .Roboto_Regular:
            return UIFont.init(name: "Roboto-Regular", size: size)
        case .ProximaNova_Extrabold:
            return UIFont.init(name: "ProximaNova-Extrabold", size: size)
        case .ProximaNova_Light:
            return UIFont.init(name: "ProximaNova-Light", size: size)
        case .ProximaNova_Black:
            return UIFont.init(name: "ProximaNova-Black", size: size)
        case .ProximaNova_Semibold:
            return UIFont.init(name: "ProximaNova-Semibold", size: size)
        case .ProximaNova_Bold:
            return UIFont.init(name: "ProximaNova-Bold", size: size)
        case .ProximaNova_Regular:
            return UIFont.init(name: "ProximaNova-Regular", size: size)
        }
    }
}
