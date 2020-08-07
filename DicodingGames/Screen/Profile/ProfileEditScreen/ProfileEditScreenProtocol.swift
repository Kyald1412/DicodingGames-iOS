//
//  ProfileEditScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileEditScreenViewProtocol: class {
    var presenter: ProfileEditScreenPresenterProtocol? { get set }
    
    func showError()
}

protocol ProfileEditScreenWireFrameProtocol: class {
    static func createProfileEditScreenModule(forGames gameId: Int?) -> UIViewController
}

protocol ProfileEditScreenPresenterProtocol: class {
    var view: ProfileEditScreenViewProtocol? { get set }
    var interactor: ProfileEditScreenInteractorInputProtocol? { get set }
    var wireFrame: ProfileEditScreenWireFrameProtocol? { get set }
        
    func viewDidLoad()
    func onUpdateProfileData(name: String, bio: String, category: String, photo: Data)
    func onShowProfileData()

}

protocol ProfileEditScreenInteractorInputProtocol: class {
    var presenter: ProfileEditScreenInteractorOutputProtocol? { get set }
    var userDataManager: UserLocalDataManagerInputProtocol? { get set }    
    
    func retrieveProfileData()
    func updateProfileData(name: String, bio: String, category: String, photo: Data)
    
}

protocol ProfileEditScreenInteractorOutputProtocol: class {

    func didReceiveProfileData(profile: Profile)
    func didSuccessUpdateData()
    func onError()
}
