//
//  GameDetail.swift
//
//  Created by Dhiky Aldwiansyah on 01/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct GameDetail: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case creatorsCount = "creators_count"
        case esrbRating = "esrb_rating"
        case tags
        case descriptionValue = "description"
        case metacritic
        case achievementsCount = "achievements_count"
        //    case stores
        case publishers
        case redditUrl = "reddit_url"
        //    case ratings
        //    case reactions
        case moviesCount = "movies_count"
        case rating
        case website
        case ratingTop = "rating_top"
        case parentPlatforms = "parent_platforms"
        case redditDescription = "reddit_description"
        case suggestionsCount = "suggestions_count"
        case genres
        //    case addedByStatus = "added_by_status"
        case additionsCount = "additions_count"
        case screenshotsCount = "screenshots_count"
        case youtubeCount = "youtube_count"
        case backgroundImage = "background_image"
        //    case clip
        case added
        case metacriticUrl = "metacritic_url"
        case nameOriginal = "name_original"
        case descriptionRaw = "description_raw"
        case updated
        case reviewsCount = "reviews_count"
        case twitchCount = "twitch_count"
        case redditLogo = "reddit_logo"
        case tba
        case ratingsCount = "ratings_count"
        case name
        //    case platforms
        //    case developers
        case backgroundImageAdditional = "background_image_additional"
        case slug
        case dominantColor = "dominant_color"
        //    case alternativeNames = "alternative_names"
        //    case metacriticPlatforms = "metacritic_platforms"
        case saturatedColor = "saturated_color"
        case parentAchievementsCount = "parent_achievements_count"
        case playtime
        case reviewsTextCount = "reviews_text_count"
        case released
        case redditName = "reddit_name"
        case parentsCount = "parents_count"
        case gameSeriesCount = "game_series_count"
        case redditCount = "reddit_count"
    }
    
    init() {
        
    }
    
    var id: Int?
    var creatorsCount: Int?
    var esrbRating: EsrbRating?
    var tags: [Tags]?
    var descriptionValue: String?
    var metacritic: Int?
    var achievementsCount: Int?
    //  var stores: [Stores]?
    var publishers: [Publishers]?
    var redditUrl: String?
    //  var ratings: [Ratings]?
    //  var reactions: Reactions?
    var moviesCount: Int?
    var rating: Float?
    var website: String?
    var ratingTop: Int?
    var parentPlatforms: [ParentPlatforms]?
    var redditDescription: String?
    var suggestionsCount: Int?
    var genres: [Genres]?
    //  var addedByStatus: AddedByStatus?
    var additionsCount: Int?
    var screenshotsCount: Int?
    var youtubeCount: Int?
    var backgroundImage: String?
    //  var clip: Clip?
    var added: Int?
    var metacriticUrl: String?
    var nameOriginal: String?
    var descriptionRaw: String?
    var updated: String?
    var reviewsCount: Int?
    var twitchCount: Int?
    var redditLogo: String?
    var tba: Bool?
    var ratingsCount: Int?
    var name: String?
    //  var platforms: [Platforms]?
    //  var developers: [Developers]?
    var backgroundImageAdditional: String?
    var slug: String?
    var dominantColor: String?
    //  var alternativeNames: Any?
    //  var metacriticPlatforms: Any?
    var saturatedColor: String?
    var parentAchievementsCount: Int?
    var playtime: Int?
    var reviewsTextCount: Int?
    var released: String?
    var redditName: String?
    var parentsCount: Int?
    var gameSeriesCount: Int?
    var redditCount: Int?
    
    var platformStringBuilder: String = ""
    var genresStringBuilder: String = ""
    var publishersStringBuilder: String = ""
    var esrbImageName: String = ""
    var ratingBuilder: String = ""

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        creatorsCount = try container.decodeIfPresent(Int.self, forKey: .creatorsCount)
        esrbRating = try container.decodeIfPresent(EsrbRating.self, forKey: .esrbRating)
        tags = try container.decodeIfPresent([Tags].self, forKey: .tags)
        descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
        metacritic = try container.decodeIfPresent(Int.self, forKey: .metacritic)
        achievementsCount = try container.decodeIfPresent(Int.self, forKey: .achievementsCount)
        //    stores = try container.decodeIfPresent([Stores].self, forKey: .stores)
        publishers = try container.decodeIfPresent([Publishers].self, forKey: .publishers)
        redditUrl = try container.decodeIfPresent(String.self, forKey: .redditUrl)
        //    ratings = try container.decodeIfPresent([Ratings].self, forKey: .ratings)
        //    reactions = try container.decodeIfPresent(Reactions.self, forKey: .reactions)
        moviesCount = try container.decodeIfPresent(Int.self, forKey: .moviesCount)
        rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        ratingTop = try container.decodeIfPresent(Int.self, forKey: .ratingTop)
        parentPlatforms = try container.decodeIfPresent([ParentPlatforms].self, forKey: .parentPlatforms)
        redditDescription = try container.decodeIfPresent(String.self, forKey: .redditDescription)
        suggestionsCount = try container.decodeIfPresent(Int.self, forKey: .suggestionsCount)
        genres = try container.decodeIfPresent([Genres].self, forKey: .genres)
        //    addedByStatus = try container.decodeIfPresent(AddedByStatus.self, forKey: .addedByStatus)
        additionsCount = try container.decodeIfPresent(Int.self, forKey: .additionsCount)
        screenshotsCount = try container.decodeIfPresent(Int.self, forKey: .screenshotsCount)
        youtubeCount = try container.decodeIfPresent(Int.self, forKey: .youtubeCount)
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        //    clip = try container.decodeIfPresent(Clip.self, forKey: .clip)
        added = try container.decodeIfPresent(Int.self, forKey: .added)
        metacriticUrl = try container.decodeIfPresent(String.self, forKey: .metacriticUrl)
        nameOriginal = try container.decodeIfPresent(String.self, forKey: .nameOriginal)
        descriptionRaw = try container.decodeIfPresent(String.self, forKey: .descriptionRaw)
        updated = try container.decodeIfPresent(String.self, forKey: .updated)
        reviewsCount = try container.decodeIfPresent(Int.self, forKey: .reviewsCount)
        twitchCount = try container.decodeIfPresent(Int.self, forKey: .twitchCount)
        redditLogo = try container.decodeIfPresent(String.self, forKey: .redditLogo)
        tba = try container.decodeIfPresent(Bool.self, forKey: .tba)
        ratingsCount = try container.decodeIfPresent(Int.self, forKey: .ratingsCount)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        //    platforms = try container.decodeIfPresent([Platforms].self, forKey: .platforms)
        //    developers = try container.decodeIfPresent([Developers].self, forKey: .developers)
        backgroundImageAdditional = try container.decodeIfPresent(String.self, forKey: .backgroundImageAdditional)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        dominantColor = try container.decodeIfPresent(String.self, forKey: .dominantColor)
        //    alternativeNames = try container.decodeIfPresent([].self, forKey: .alternativeNames)
        //    metacriticPlatforms = try container.decodeIfPresent([].self, forKey: .metacriticPlatforms)
        saturatedColor = try container.decodeIfPresent(String.self, forKey: .saturatedColor)
        parentAchievementsCount = try container.decodeIfPresent(Int.self, forKey: .parentAchievementsCount)
        playtime = try container.decodeIfPresent(Int.self, forKey: .playtime)
        reviewsTextCount = try container.decodeIfPresent(Int.self, forKey: .reviewsTextCount)
        released = try container.decodeIfPresent(String.self, forKey: .released)
        redditName = try container.decodeIfPresent(String.self, forKey: .redditName)
        parentsCount = try container.decodeIfPresent(Int.self, forKey: .parentsCount)
        gameSeriesCount = try container.decodeIfPresent(Int.self, forKey: .gameSeriesCount)
        redditCount = try container.decodeIfPresent(Int.self, forKey: .redditCount)
        
        
        if let rating = rating {
                  ratingBuilder = ""
                   
                  if rating == 0 {
                      ratingBuilder = "-"
                  } else {
                      ratingBuilder = "\(rating)"
                  }
              }
        
        if let genres = genres {
            genresStringBuilder = ""
            
            for genreData in genres {
                genresStringBuilder.append("\(genreData.name ?? "")")
                genresStringBuilder.append(", ")
            }
            
            
            genresStringBuilder = String(genresStringBuilder.dropLast())
            genresStringBuilder = String(genresStringBuilder.dropLast())
            
            if genresStringBuilder.count == 0 {
                genresStringBuilder = "-"
            }
        }
        
        if let parentPlatforms = parentPlatforms {
            platformStringBuilder = ""
            for platformData in parentPlatforms {
                platformStringBuilder.append("\(platformData.platform?.name ?? "")")
                platformStringBuilder.append(", ")
            }
            platformStringBuilder = String(platformStringBuilder.dropLast())
            platformStringBuilder = String(platformStringBuilder.dropLast())
            
            if platformStringBuilder.count == 0 {
                platformStringBuilder = "-"
            }
        }
        
        
        if let publishers = publishers {
            publishersStringBuilder  = ""
            for publisherData in publishers {
                publishersStringBuilder.append("\(publisherData.name ?? "")")
                publishersStringBuilder.append(" | ")
            }
            publishersStringBuilder = String(publishersStringBuilder.dropLast())
            publishersStringBuilder = String(publishersStringBuilder.dropLast())
            
            if publishersStringBuilder.count == 0 {
                publishersStringBuilder = "-"
            }
        }
        
        if let esrbData = esrbRating {
            switch esrbData.id {
            case 0:
                esrbImageName =  "esrb_children"
                break
            case 1:
                esrbImageName =  "esrb_everyone"
                break
            case 2:
                esrbImageName =  "esrb_everyone10"
                break
            case 3:
                esrbImageName =  "esrb_teen"
                break
            case 4:
                esrbImageName =  "esrb_mature"
                break
            case 5:
                esrbImageName =  "esrb_adult"
                break
            default:
                esrbImageName =  ""
            }
        }
    }
    
}
