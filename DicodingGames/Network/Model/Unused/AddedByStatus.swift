//
//  AddedByStatus.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct AddedByStatus: Codable {

  enum CodingKeys: String, CodingKey {
    case playing
    case beaten
    case yet
    case dropped
    case owned
    case toplay
  }

  var playing: Int?
  var beaten: Int?
  var yet: Int?
  var dropped: Int?
  var owned: Int?
  var toplay: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    playing = try container.decodeIfPresent(Int.self, forKey: .playing)
    beaten = try container.decodeIfPresent(Int.self, forKey: .beaten)
    yet = try container.decodeIfPresent(Int.self, forKey: .yet)
    dropped = try container.decodeIfPresent(Int.self, forKey: .dropped)
    owned = try container.decodeIfPresent(Int.self, forKey: .owned)
    toplay = try container.decodeIfPresent(Int.self, forKey: .toplay)
  }

}
