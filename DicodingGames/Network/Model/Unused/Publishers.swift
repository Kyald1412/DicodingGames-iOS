//
//  Publishers.swift
//
//  Created by Dhiky Aldwiansyah on 01/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Publishers: Codable {

  enum CodingKeys: String, CodingKey {
    case gamesCount = "games_count"
    case slug
    case name
    case imageBackground = "image_background"
    case id
  }

  var gamesCount: Int?
  var slug: String?
  var name: String?
  var imageBackground: String?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gamesCount = try container.decodeIfPresent(Int.self, forKey: .gamesCount)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
