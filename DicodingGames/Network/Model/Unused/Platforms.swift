//
//  Platforms.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Platforms: Codable {

  enum CodingKeys: String, CodingKey {
    case releasedAt = "released_at"
    case requirementsEn = "requirements_en"
    case platform
  }

  var releasedAt: String?
  var requirementsEn: RequirementsEn?
  var platform: Platform?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    releasedAt = try container.decodeIfPresent(String.self, forKey: .releasedAt)
    requirementsEn = try container.decodeIfPresent(RequirementsEn.self, forKey: .requirementsEn)
    platform = try container.decodeIfPresent(Platform.self, forKey: .platform)
  }

}
