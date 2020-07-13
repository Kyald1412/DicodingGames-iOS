//
//  ProfileScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

class ProfileScreenPresenter: ProfileScreenPresenterProtocol {
 
    
    weak var view: ProfileScreenViewProtocol?
    var wireFrame: ProfileScreenWireFrameProtocol?
    var userDataManager: UserLocalDataManagerInputProtocol?
    var academyDataManager: AcademyLocalDataManagerInputProtocol?

    func viewDidLoad() {
        onLoadProfile()
        onLoadAcademies()
    }
    
    
    func onLoadAcademies() {
                
        do {
            guard let data = try academyDataManager?.retrieveAcademyGamesList() else {
                return
            }
            view?.showAcademyData(academy: data)
        } catch {
            
        }
    }
    
    func deleteAcademy(id: Int){
        DispatchQueue.main.async {
            
            do {
                try self.academyDataManager?.deleteAcademyGame(id: id)
            } catch {
                
            }
        }
        DispatchQueue.main.async {
            
            self.onLoadAcademies()
        }
        
    }

    func onLoadProfile() {
                
        do {
            guard let data = try userDataManager?.retrieveUserData() else {
                return
            }
            view?.showProfileData(profile: data)
        } catch {
            
        }
    }
    
    func showAcademyEditScreen(id: Int) {
        wireFrame?.presentAcademyEditScreen(from: view!, id: id)
     }
    func showProfileEditScreen() {
        wireFrame?.presentProfileEditScreen(from: view!)
    }
    func showAcademyAddScreen(){
        wireFrame?.presentAcademyScreen(from: view!)
    }

}
