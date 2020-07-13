//
//  ProfileEditScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Combine
import Foundation

class ProfileEditScreenInteractor: ProfileEditScreenInteractorInputProtocol {
    
    
    weak var presenter: ProfileEditScreenInteractorOutputProtocol?
    var userDataManager: UserLocalDataManagerInputProtocol?
    
    func retrieveProfileData() {
        do {
            
            guard let data = try userDataManager?.retrieveUserData() else {
                return
            }
            self.presenter?.didReceiveProfileData(profile: data)
        } catch {
            
        }
    }
    
    func updateProfileData(name: String, bio: String, category: String,photo:Data) {
        do {
            
            try userDataManager?.updateUserData(id: 0, name: name, bio: bio, category: category, photo: photo)
        } catch {
            
        }
        
        self.presenter?.didSuccessUpdateData()
        
    }
    
    func deleteGameProfileEditData(gameId: Int) {
        
        
    }
    
    
    
}
