//
//  Validation.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 15/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

enum Validation {
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
