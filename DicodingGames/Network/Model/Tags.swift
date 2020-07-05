//
//  Tags.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Tags: Codable {

  enum CodingKeys: String, CodingKey {
    case language
    case gamesCount = "games_count"
    case name
    case slug
    case imageBackground = "image_background"
    case id
  }

  var language: String?
  var gamesCount: Int?
  var name: String?
  var slug: String?
  var imageBackground: String?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    language = try container.decodeIfPresent(String.self, forKey: .language)
    gamesCount = try container.decodeIfPresent(Int.self, forKey: .gamesCount)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
