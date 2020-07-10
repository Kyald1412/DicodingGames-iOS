//
//  ProfileAcademyScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileAcademyScreenViewProtocol: class {
    var presenter: ProfileAcademyScreenPresenterProtocol? { get set }
    
        func showError()
}

protocol ProfileAcademyScreenWireFrameProtocol: class {
    static func createProfileAcademyScreenModule(forGames gameId: Int?) -> UIViewController
}

protocol ProfileAcademyScreenPresenterProtocol: class {
    var view: ProfileAcademyScreenViewProtocol? { get set }
    var interactor: ProfileAcademyScreenInteractorInputProtocol? { get set }
    var wireFrame: ProfileAcademyScreenWireFrameProtocol? { get set }
        
    func viewDidLoad()
}

protocol ProfileAcademyScreenInteractorInputProtocol: class {
    var presenter: ProfileAcademyScreenInteractorOutputProtocol? { get set }
    
}

protocol ProfileAcademyScreenInteractorOutputProtocol: class {

    func onError()
}
