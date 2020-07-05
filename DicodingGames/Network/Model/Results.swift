//
//  Results.swift
//
//  Created by Dhiky Aldwiansyah on 30/06/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import Combine

final class Results {
    var added: Int?
    //  var clip: Clip?
    var rating: Float?
    //  var ratings: [Ratings]?
    var dominantColor: String?
    @Published var backgroundImage: String = ""
    @Published var name: String = ""
    var playtime: Int?
    var saturatedColor: String?
    @Published var id: Int = 0
    var slug: String?
    var tba: Bool?
    var reviewsCount: Int?
    var metacritic: Int?
    var ratingTop: Int?
    var parentPlatforms: [ParentPlatforms]?
    var reviewsTextCount: Int?
    var shortScreenshots: [ShortScreenshots]?
    var tags: [Tags]?
    //  var addedByStatus: AddedByStatus?
    var genres: [Genres]?
    //  var stores: [Stores]?
    var released: String?
    var suggestionsCount: Int?
    //  var platforms: [Platforms]?
    var ratingsCount: Int?
    
    
    init() {
        
    }
    
   required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        added = try container.decodeIfPresent(Int.self, forKey: .added)
        //    clip = try container.decodeIfPresent(Clip.self, forKey: .clip)
        rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        //    ratings = try container.decodeIfPresent([Ratings].self, forKey: .ratings)
        dominantColor = try container.decodeIfPresent(String.self, forKey: .dominantColor)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        name = try container.decode(String.self, forKey: .name)
        playtime = try container.decodeIfPresent(Int.self, forKey: .playtime)
        saturatedColor = try container.decodeIfPresent(String.self, forKey: .saturatedColor)
        id = try container.decode(Int.self, forKey: .id)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        tba = try container.decodeIfPresent(Bool.self, forKey: .tba)
        reviewsCount = try container.decodeIfPresent(Int.self, forKey: .reviewsCount)
        metacritic = try container.decodeIfPresent(Int.self, forKey: .metacritic)
        ratingTop = try container.decodeIfPresent(Int.self, forKey: .ratingTop)
        parentPlatforms = try container.decodeIfPresent([ParentPlatforms].self, forKey: .parentPlatforms)
        reviewsTextCount = try container.decodeIfPresent(Int.self, forKey: .reviewsTextCount)
        shortScreenshots = try container.decodeIfPresent([ShortScreenshots].self, forKey: .shortScreenshots)
        tags = try container.decodeIfPresent([Tags].self, forKey: .tags)
        //    addedByStatus = try container.decodeIfPresent(AddedByStatus.self, forKey: .addedByStatus)
        genres = try container.decodeIfPresent([Genres].self, forKey: .genres)
        //    stores = try container.decodeIfPresent([Stores].self, forKey: .stores)
        released = try container.decodeIfPresent(String.self, forKey: .released)
        suggestionsCount = try container.decodeIfPresent(Int.self, forKey: .suggestionsCount)
        //    platforms = try container.decodeIfPresent([Platforms].self, forKey: .platforms)
        ratingsCount = try container.decodeIfPresent(Int.self, forKey: .ratingsCount)
        
    }
}
extension Results: Codable {
    
    enum CodingKeys: String, CodingKey {
        case added
        //    case clip
        case rating
        //    case ratings
        case dominantColor = "dominant_color"
        case backgroundImage = "background_image"
        case name
        case playtime
        case saturatedColor = "saturated_color"
        case id
        case slug
        case tba
        case reviewsCount = "reviews_count"
        case metacritic
        case ratingTop = "rating_top"
        case parentPlatforms = "parent_platforms"
        case reviewsTextCount = "reviews_text_count"
        case shortScreenshots = "short_screenshots"
        case tags
        //    case addedByStatus = "added_by_status"
        case genres
        //    case stores
        case released
        case suggestionsCount = "suggestions_count"
        //    case platforms
        case ratingsCount = "ratings_count"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(added, forKey: .added)
        //        try container.encode(clip, forKey: .clip)
        try container.encode(rating, forKey: .rating)
        //        try container.encode(ratings, forKey: .ratings)
        try container.encode(dominantColor, forKey: .dominantColor)
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(name, forKey: .name)
        try container.encode(playtime, forKey: .playtime)
        try container.encode(saturatedColor, forKey: .saturatedColor)
        try container.encode(id, forKey: .id)
        try container.encode(slug, forKey: .slug)
        try container.encode(tba, forKey: .tba)
        try container.encode(reviewsCount, forKey: .reviewsCount)
        try container.encode(metacritic, forKey: .metacritic)
        try container.encode(ratingTop, forKey: .ratingTop)
        try container.encode(parentPlatforms, forKey: .parentPlatforms)
        try container.encode(reviewsTextCount, forKey: .reviewsTextCount)
        try container.encode(shortScreenshots, forKey: .shortScreenshots)
        try container.encode(tags, forKey: .tags)
        //        try container.encode(addedByStatus, forKey: .addedByStatus)
        try container.encode(genres, forKey: .genres)
        //        try container.encode(stores, forKey: .stores)
        try container.encode(released, forKey: .released)
        try container.encode(suggestionsCount, forKey: .suggestionsCount)
        //        try container.encode(platforms, forKey: .platforms)
        try container.encode(ratingsCount, forKey: .ratingsCount)
        
    }
    
}


extension Results: Identifiable {}

extension Results: ObservableObject {}

extension Results: Equatable {
  static func == (lhs: Results, rhs: Results) -> Bool {
    lhs.id == rhs.id
  }
}
