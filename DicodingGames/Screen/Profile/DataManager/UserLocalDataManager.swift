//
//  UserLocalDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import CoreData

protocol UserLocalDataManagerInputProtocol: class {
    func retrieveUserData() throws -> Profile
    func updateUserData(id: Int, name: String, bio: String, category: String, photo: Data) throws
}

class UserLocalDataManager:UserLocalDataManagerInputProtocol {
  
    func retrieveUserData() throws -> Profile   {
                        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        let request: NSFetchRequest<Profile> = NSFetchRequest(entityName: String(describing: Profile.self))
        
        print("data \(try managedOC.fetch(request))")

        return try managedOC.fetch(request)[0]
    }
    
    
    func createUserData(id: Int, name: String, bio: String, category: String, photo: Data, completion: @escaping() -> ())  {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            print("Failure OC")
            return
        }
        
        if let newProfile = NSEntityDescription.entity(forEntityName: "Profile",
                                                       in: managedOC) {
            
            let profile = Profile(entity: newProfile, insertInto: managedOC)
            
            profile.id = Int32(id)
            profile.name = name
            profile.bio = bio
            profile.category = category
            profile.photo = photo
            
            do {
                try managedOC.save()
                completion()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
        
    }

    func updateUserData(id: Int, name: String, bio: String, category: String, photo: Data) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Profile> = NSFetchRequest(entityName: String(describing: Profile.self))
        request.predicate = NSPredicate(format: "id = %d", Int32(id))
        
        
        let dataToUpdate = try managedOC.fetch(request)[0] as NSManagedObject
        
        dataToUpdate.setValue(name, forKey: "name")
        dataToUpdate.setValue(bio, forKey: "bio")
        dataToUpdate.setValue(category, forKey: "category")
        dataToUpdate.setValue(photo, forKey: "photo")

        try managedOC.save()
        
        throw PersistenceError.couldNotSaveObject

    }
   

}
