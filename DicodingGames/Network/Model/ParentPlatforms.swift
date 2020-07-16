//
//  ParentPlatforms.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ParentPlatforms: Codable {
    
    enum CodingKeys: String, CodingKey {
        case platform
    }
    
    var platform: Platform?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        platform = try container.decodeIfPresent(Platform.self, forKey: .platform)
    }
    
}
