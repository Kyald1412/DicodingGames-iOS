//
//  FavoriteLocalDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import CoreData

protocol FavoriteLocalDataManagerInputProtocol: class {
    func retrieveFavoriteGamesList() throws -> [FavoriteGames]
    func saveFavoriteGame(id: Int, title: String, desc: String, rating: String, imageUrl: String) throws
    func deleteFavoriteGame(id: Int) throws
    func retrieveFavoriteGamesById(gameId: Int) throws -> Bool
    func retrieveFavoriteGamesCount() throws -> Bool
}

class FavoriteLocalDataManager:FavoriteLocalDataManagerInputProtocol {
    func retrieveFavoriteGamesCount() throws -> Bool {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        let request: NSFetchRequest<FavoriteGames> = NSFetchRequest(entityName: String(describing: FavoriteGames.self))

        if try managedOC.fetch(request).count > 0 {
            return true
        }
        
        return false
    }
    
    
    func retrieveFavoriteGamesById(gameId: Int) throws -> Bool   {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        let request: NSFetchRequest<FavoriteGames> = NSFetchRequest(entityName: String(describing: FavoriteGames.self))
        request.predicate = NSPredicate(format: "game_id = %d", Int32(gameId))

        if try managedOC.fetch(request).count > 0 {
            return true
        }
        
        return false
    }
    
    func retrieveFavoriteGamesList() throws -> [FavoriteGames]   {
                
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        let request: NSFetchRequest<FavoriteGames> = NSFetchRequest(entityName: String(describing: FavoriteGames.self))
        
        return try managedOC.fetch(request)
    }

    func saveFavoriteGame(id: Int, title: String, desc: String, rating: String, imageUrl: String) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newFavoriteGames = NSEntityDescription.entity(forEntityName: "FavoriteGames",
                                                           in: managedOC) {
                    
            let favoriteGames = FavoriteGames(entity: newFavoriteGames, insertInto: managedOC)
            
            
            favoriteGames.game_id = Int32(id)
            favoriteGames.game_desc = desc
            favoriteGames.game_title = title
            favoriteGames.game_img_url = imageUrl
            favoriteGames.game_ratings = rating
            try managedOC.save()
        }
        throw PersistenceError.couldNotSaveObject

    }
   
    func deleteFavoriteGame(id: Int) throws {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<FavoriteGames> = NSFetchRequest(entityName: String(describing: FavoriteGames.self))
        request.predicate = NSPredicate(format: "game_id = %d", Int32(id))
        
        let dataToDelete = try managedOC.fetch(request)[0] as NSManagedObject
        managedOC.delete(dataToDelete)
        
        try managedOC.save()
        
        throw PersistenceError.couldNotSaveObject
        
    }
    

}
