//
//  String+Extensions.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 16/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

extension String {
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
