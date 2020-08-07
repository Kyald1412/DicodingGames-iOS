//
//  Stores.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Stores: Codable {

  enum CodingKeys: String, CodingKey {
    case store
    case urlEn = "url_en"
    case urlRu = "url_ru"
    case id
  }

  var store: Store?
  var urlEn: String?
  var urlRu: String?
  var id: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    store = try container.decodeIfPresent(Store.self, forKey: .store)
    urlEn = try container.decodeIfPresent(String.self, forKey: .urlEn)
    urlRu = try container.decodeIfPresent(String.self, forKey: .urlRu)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
