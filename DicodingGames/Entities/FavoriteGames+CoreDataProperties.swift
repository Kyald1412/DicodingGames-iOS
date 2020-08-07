//
//  FavoriteGames+Extensions.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

extension FavoriteGames: Identifiable {

    @NSManaged public var gameId: Int32
    @NSManaged public var gameImgUrl: String
    @NSManaged public var gameTitle: String
    @NSManaged public var gameDesc: String
    @NSManaged public var gameRatings: String
    @NSManaged public var gameReleaseDate: String

}
