//
//  ProfileScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileScreenViewProtocol: class {
    var presenter: ProfileScreenPresenterProtocol? { get set }
    
    func showProfileData(profile: Profile)
    func showAcademyData(academy: [Academy])
    func onDeleteAcademyData(academy: [Academy])

}

protocol ProfileScreenWireFrameProtocol: class {
    static func createProfileScreenModule() -> UIViewController
    
    func presentProfileEditScreen(from view: ProfileScreenViewProtocol)
    func presentAcademyScreen(from view: ProfileScreenViewProtocol)
    func presentAcademyEditScreen(from view: ProfileScreenViewProtocol, id: Int)
}

protocol ProfileScreenPresenterProtocol: class {
    var view: ProfileScreenViewProtocol? { get set }
    var wireFrame: ProfileScreenWireFrameProtocol? { get set }
    var userDataManager: UserLocalDataManagerInputProtocol? { get set }
    var academyDataManager: AcademyLocalDataManagerInputProtocol? {get set}
    
    func viewDidLoad()
    func showProfileEditScreen()
    func showAcademyAddScreen()
    func showAcademyEditScreen(id: Int)
    func deleteAcademy(id: Int)

}
