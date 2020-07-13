//
//  HomeLocalDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import CoreData

protocol HomeLocalDataManagerInputProtocol: class {
    func retrieveCurrentNewRelease(completion: @escaping(_ games: NewGames) -> ())
    func saveNewGames(id: Int) throws
}

class HomeLocalDataManager:HomeLocalDataManagerInputProtocol {
  
    func retrieveCurrentNewRelease(completion: @escaping(_ games: NewGames) -> ())  {
                
        guard let managedOC = CoreDataStore.managedObjectContext else {
            return
        }

        let request: NSFetchRequest<NewGames> = NSFetchRequest(entityName: String(describing: NewGames.self))
        
        do {
            let data = try managedOC.fetch(request)
            
            if(data.count > 0){
                completion(data[0])
                
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func saveNewGames(id: Int) {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            return
        }
        
        let request: NSFetchRequest<NewGames> = NSFetchRequest(entityName: String(describing: NewGames.self))
        request.predicate = NSPredicate(format: "id = %d", Int32(0))
        
        
        do {
            
            let data = try managedOC.fetch(request)
            
            if(data.count > 0){
                
                let dataToUpdate = data[0] as NSManagedObject
                
                dataToUpdate.setValue(id, forKey: "game_id")

                try managedOC.save()
            } else {
                
                if let newGames = NSEntityDescription.entity(forEntityName: "NewGames",
                                                             in: managedOC) {
                    
                    let games = NewGames(entity: newGames, insertInto: managedOC)
                    
                    games.id = Int32(0)
                    games.game_id = Int32(id)
                    try managedOC.save()
                    
                }
            }
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
