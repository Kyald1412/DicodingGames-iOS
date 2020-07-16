//
//  Ratings.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Ratings: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case count
    case percent
  }

  var id: Int?
  var title: String?
  var count: Int?
  var percent: Float?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
    percent = try container.decodeIfPresent(Float.self, forKey: .percent)
  }

}
