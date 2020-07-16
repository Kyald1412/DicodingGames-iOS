//
//  NewGames+CoreDataProperties.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import CoreData
extension NewGames: Identifiable  {

    @NSManaged public var id: Int32
    @NSManaged public var game_id: Int32

}
