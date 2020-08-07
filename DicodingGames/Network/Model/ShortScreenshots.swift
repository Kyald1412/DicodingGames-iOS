//
//  ShortScreenshots.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

struct ShortScreenshots: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case image
  }

  var id: Int?
  var image: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    image = try container.decodeIfPresent(String.self, forKey: .image)
  }

}
