//
//  Clip.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Clip: Codable {

  enum CodingKeys: String, CodingKey {
    case preview
    case clip
    case clips
    case video
  }

  var preview: String?
  var clip: String?
  var clips: Clips?
  var video: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    preview = try container.decodeIfPresent(String.self, forKey: .preview)
    clip = try container.decodeIfPresent(String.self, forKey: .clip)
    clips = try container.decodeIfPresent(Clips.self, forKey: .clips)
    video = try container.decodeIfPresent(String.self, forKey: .video)
  }

}
