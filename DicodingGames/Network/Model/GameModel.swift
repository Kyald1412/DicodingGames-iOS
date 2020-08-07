//
//  GameModel.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct GameModel: Codable {

  enum CodingKeys: String, CodingKey {
    case seoTitle = "seo_title"
    case seoH1 = "seo_h1"
    case nofollow
    case next
    case nofollowCollections = "nofollow_collections"
    case count
//    case filters
    case seoDescription = "seo_description"
    case seoKeywords = "seo_keywords"
    case noindex
    case descriptionValue = "description"
    case results
  }

  var seoTitle: String?
  var seoH1: String?
  var nofollow: Bool?
  var next: String?
  var nofollowCollections: [String]?
  var count: Int?
//  var filters: Filters?
  var seoDescription: String?
  var seoKeywords: String?
  var noindex: Bool?
  var descriptionValue: String?
  var results: [Results]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    seoTitle = try container.decodeIfPresent(String.self, forKey: .seoTitle)
    seoH1 = try container.decodeIfPresent(String.self, forKey: .seoH1)
    nofollow = try container.decodeIfPresent(Bool.self, forKey: .nofollow)
    next = try container.decodeIfPresent(String.self, forKey: .next)
    nofollowCollections = try container.decodeIfPresent([String].self, forKey: .nofollowCollections)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
//    filters = try container.decodeIfPresent(Filters.self, forKey: .filters)
    seoDescription = try container.decodeIfPresent(String.self, forKey: .seoDescription)
    seoKeywords = try container.decodeIfPresent(String.self, forKey: .seoKeywords)
    noindex = try container.decodeIfPresent(Bool.self, forKey: .noindex)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    results = try container.decodeIfPresent([Results].self, forKey: .results)
  }

}
