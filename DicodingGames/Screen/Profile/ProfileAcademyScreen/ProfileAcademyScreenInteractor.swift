//
//  ProfileAcademyScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Combine
import Foundation

class ProfileAcademyScreenInteractor: ProfileAcademyScreenInteractorInputProtocol {
    
    weak var presenter: ProfileAcademyScreenInteractorOutputProtocol?
    var academyDataManager: AcademyLocalDataManagerInputProtocol?
    
    func retrieveAcademyDataById(id: Int) {
        do {
            guard let data = try academyDataManager?.retrieveAcademyById(id: id) else {
                return
            }
            self.presenter?.didReceiveAcademyData(academy: data)
            
        } catch {
            
        }
    }
    
    func addAcademyData(title: String, description: String, photo: Data) {
        do {
            try academyDataManager?.saveAcademyGame(title: title, desc: description, imageUrl: photo)
        } catch {
            
        }
    }
    
    func editAcademyData(id: Int, title: String, description: String, photo: Data) {
          do {
            try academyDataManager?.updateAcademy(id: id, name: title, desc: description, photo: photo)
          } catch {
              
          }
      }
    
}
