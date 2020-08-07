//
//  Filters.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Filters: Codable {

  enum CodingKeys: String, CodingKey {
    case years
  }

  var years: [Years]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    years = try container.decodeIfPresent([Years].self, forKey: .years)
  }

}
