//
//  Years.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Years: Codable {

  enum CodingKeys: String, CodingKey {
    case year
    case count
    case nofollow
  }

  var year: Int?
  var count: Int?
  var nofollow: Bool?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    year = try container.decodeIfPresent(Int.self, forKey: .year)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
    nofollow = try container.decodeIfPresent(Bool.self, forKey: .nofollow)
  }

}
