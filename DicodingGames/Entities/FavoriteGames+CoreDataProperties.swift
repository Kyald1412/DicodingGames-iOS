//
//  FavoriteGames+Extensions.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

extension FavoriteGames: Identifiable  {

    @NSManaged public var game_id: Int32
    @NSManaged public var game_img_url: String
    @NSManaged public var game_title: String
    @NSManaged public var game_desc: String
    @NSManaged public var game_ratings: String
    @NSManaged public var game_release_date: String

}
