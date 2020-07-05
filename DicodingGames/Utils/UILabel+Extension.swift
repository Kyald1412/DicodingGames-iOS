//
//  UILabel+Extension.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func addInterlineSpacing(spacingValue: CGFloat = 2) {

        guard let textString = text else { return }

        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        attributedText = attributedString
    }

}
