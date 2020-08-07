//
//  RequirementsEn.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct RequirementsEn: Codable {

  enum CodingKeys: String, CodingKey {
    case recommended
    case minimum
  }

  var recommended: String?
  var minimum: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    recommended = try container.decodeIfPresent(String.self, forKey: .recommended)
    minimum = try container.decodeIfPresent(String.self, forKey: .minimum)
  }

}
