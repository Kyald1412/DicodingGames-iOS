//
//  Store.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Store: Codable {

  enum CodingKeys: String, CodingKey {
    case gamesCount = "games_count"
    case imageBackground = "image_background"
    case name
    case domain
    case id
    case slug
  }

  var gamesCount: Int?
  var imageBackground: String?
  var name: String?
  var domain: String?
  var id: Int?
  var slug: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gamesCount = try container.decodeIfPresent(Int.self, forKey: .gamesCount)
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    domain = try container.decodeIfPresent(String.self, forKey: .domain)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
  }

}
