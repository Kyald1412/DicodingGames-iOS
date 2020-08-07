//
//  Profile.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Profile: NSManagedObject {
    
    func initData(completion: @escaping() -> Void) {
        
        guard let image = UIImage(named: "me") else { return }
        let jpegData = image.jpegData(compressionQuality: 1.0)!

        UserLocalDataManager().createUserData(id: 0, name: "Dhiky Aldwiansyah", bio: "\"I love turning great ideas into reality\"", category: "Dicoding Member", photo: jpegData) {
            completion()
        }
        
    }
    
}
