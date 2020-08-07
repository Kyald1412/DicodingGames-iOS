//
//  AcademyLocalDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import CoreData

protocol AcademyLocalDataManagerInputProtocol: class {
    func retrieveAcademyGamesList() throws -> [Academy]
    func saveAcademyGame(title: String, desc: String, imageUrl: Data) throws
    func deleteAcademyGame(id: Int) throws
    func createAcademyData(id: Int, name: String, desc: String, photo: Data)
    func retrieveAcademyById(id: Int) throws -> Academy
    func updateAcademy(id: Int, name: String, desc: String, photo: Data) throws
}

class AcademyLocalDataManager: AcademyLocalDataManagerInputProtocol {
    
       func createAcademyData(id: Int, name: String, desc: String, photo: Data) {
           guard let managedOC = CoreDataStore.managedObjectContext else {
               print("Failure OC")
               return
           }
           
           if let newAcademy = NSEntityDescription.entity(forEntityName: "Academy",
                                                          in: managedOC) {
               
               let academy = Academy(entity: newAcademy, insertInto: managedOC)
               
               academy.id = Int32(id)
               academy.name = name
               academy.desc = desc
               academy.photo = photo
               
               do {
                   try managedOC.save()
               } catch let error as NSError {
                   print("Could not save. \(error), \(error.userInfo)")
               }
               
           }
           
       }
    
    func retrieveAcademyGamesList() throws -> [Academy] {
                
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        let request: NSFetchRequest<Academy> = NSFetchRequest(entityName: String(describing: Academy.self))
        
        return try managedOC.fetch(request)
    }
    
    func retrieveAcademyById(id: Int) throws -> Academy {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
    
        let request: NSFetchRequest<Academy> = NSFetchRequest(entityName: String(describing: Academy.self))
        request.predicate = NSPredicate(format: "id = %d", Int32(id))
        
        return try managedOC.fetch(request)[0]
    }

    func saveAcademyGame(title: String, desc: String, imageUrl: Data) throws {
        
         let currentCount = try retrieveAcademyGamesList().count
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newAcademyGames = NSEntityDescription.entity(forEntityName: "Academy",
                                                           in: managedOC) {
            
            let favoriteGames = Academy(entity: newAcademyGames, insertInto: managedOC)
            
            favoriteGames.id = Int32(currentCount+1)
            favoriteGames.desc = desc
            favoriteGames.name = title
            favoriteGames.photo = imageUrl
            
            print("favorite \(favoriteGames)")
            
            try managedOC.save()
        }
        
        throw PersistenceError.couldNotSaveObject

    }
    
    func updateAcademy(id: Int, name: String, desc: String, photo: Data) throws {
           guard let managedOC = CoreDataStore.managedObjectContext else {
               throw PersistenceError.managedObjectContextNotFound
           }
           
           let request: NSFetchRequest<Academy> = NSFetchRequest(entityName: String(describing: Academy.self))
           request.predicate = NSPredicate(format: "id = %d", Int32(id))
           
           let dataToUpdate = try managedOC.fetch(request)[0] as NSManagedObject
           
           dataToUpdate.setValue(name, forKey: "name")
           dataToUpdate.setValue(desc, forKey: "desc")
           dataToUpdate.setValue(photo, forKey: "photo")

           try managedOC.save()
           
           throw PersistenceError.couldNotSaveObject

       }
   
    func deleteAcademyGame(id: Int) throws {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Academy> = NSFetchRequest(entityName: String(describing: Academy.self))
        request.predicate = NSPredicate(format: "id = %d", Int32(id))
        
        let dataToDelete = try managedOC.fetch(request)[0] as NSManagedObject
        managedOC.delete(dataToDelete)
        
        try managedOC.save()
                
        throw PersistenceError.couldNotSaveObject
        
    }

}
