//
//  Genres.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Genres: Codable {

  enum CodingKeys: String, CodingKey {
    case imageBackground = "image_background"
    case id
    case name
    case gamesCount = "games_count"
    case slug
  }

  var imageBackground: String?
  var id: Int?
  var name: String?
  var gamesCount: Int?
  var slug: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    gamesCount = try container.decodeIfPresent(Int.self, forKey: .gamesCount)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
  }

}
