//
//  Academy+Extensions.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import CoreData

extension Academy: Identifiable {
    
    @NSManaged public var id: Int32
    @NSManaged public var desc: String
    @NSManaged public var name: String
    @NSManaged public var photo: Data
    
}
