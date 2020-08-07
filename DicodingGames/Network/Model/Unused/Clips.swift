//
//  Clips.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Clips: Codable {

  enum CodingKeys: String, CodingKey {
    case HD = "640"
    case SD = "320"
    case full
  }

  var HD: String?
  var SD: String?
  var full: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    HD = try container.decodeIfPresent(String.self, forKey: .HD)
    HD = try container.decodeIfPresent(String.self, forKey: .HD)
    full = try container.decodeIfPresent(String.self, forKey: .full)
  }

}
