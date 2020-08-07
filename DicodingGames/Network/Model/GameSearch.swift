//
//  GameDetailScreenshots.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct GameSearch: Codable {

  enum CodingKeys: String, CodingKey {
    case count
    case next
    case previous
    case results
  }

  var count: Int?
  var next: String?
  var previous: String?
  var results: [Results]?

  init() {}
    
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
    next = try container.decodeIfPresent(String.self, forKey: .next)
    previous = try container.decodeIfPresent(String.self, forKey: .previous)
    results = try container.decodeIfPresent([Results].self, forKey: .results)
  }

}

#if DEBUG
extension GameSearch {
  static var sample: GameSearch {
    let model = GameSearch()
    return model
  }
}
#endif
