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
        case esrbRating = "esrb_rating"
        case publishers
        case rating
        case genres
        case parentPlatforms = "parent_platforms"
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
        case ratingsCount = "ratings_count"
        case name
        case released
    }
    
    init() {
        
    }
    
    var id: Int?
    var esrbRating: EsrbRating?
    var rating: Float?
    var publishers: [Publishers]?
    var parentPlatforms: [ParentPlatforms]?
    var genres: [Genres]?
    var backgroundImage: String?
    var descriptionRaw: String?
    var ratingsCount: Int?
    var name: String?
    var released: String?
    
    var platformStringBuilder: String = ""
    var genresStringBuilder: String = ""
    var publishersStringBuilder: String = ""
    var esrbImageName: String = ""
    var ratingBuilder: String = ""

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        esrbRating = try container.decodeIfPresent(EsrbRating.self, forKey: .esrbRating)
        parentPlatforms = try container.decodeIfPresent([ParentPlatforms].self, forKey: .publishers)
        publishers = try container.decodeIfPresent([Publishers].self, forKey: .publishers)
        rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        genres = try container.decodeIfPresent([Genres].self, forKey: .genres)
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        descriptionRaw = try container.decodeIfPresent(String.self, forKey: .descriptionRaw)
        ratingsCount = try container.decodeIfPresent(Int.self, forKey: .ratingsCount)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        released = try container.decodeIfPresent(String.self, forKey: .released)
        
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
            case 1:
                esrbImageName =  "esrb_everyone"
            case 2:
                esrbImageName =  "esrb_everyone10"
            case 3:
                esrbImageName =  "esrb_teen"
            case 4:
                esrbImageName =  "esrb_mature"
            case 5:
                esrbImageName =  "esrb_adult"
            default:
                esrbImageName =  ""
            }
        }
    }
    
}
