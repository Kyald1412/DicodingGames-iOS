//
//  Publisher+Validation.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 15/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import Combine
import Regex

extension Published.Publisher where Value == String {
    
    func nonEmptyValidator(_ errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return ValidationPublishers.nonEmptyValidation(for: self, errorMessage: errorMessage())
    }    
    
}
