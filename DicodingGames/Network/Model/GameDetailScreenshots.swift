//
//  GameDetailScreenshots.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct GameDetailScreenshots: Codable {

  enum CodingKeys: String, CodingKey {
    case count
    case results
  }

  var count: Int?
  var results: [ShortScreenshots]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
    results = try container.decodeIfPresent([ShortScreenshots].self, forKey: .results)
  }

}
