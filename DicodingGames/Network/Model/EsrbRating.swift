//
//  EsrbRating.swift
//
//  Created by Dhiky Aldwiansyah on 01/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct EsrbRating: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
  }

  var id: Int?
  var name: String?
  var slug: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
  }

}
