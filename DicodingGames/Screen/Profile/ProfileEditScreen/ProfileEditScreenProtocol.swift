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
}

protocol ProfileEditScreenInteractorInputProtocol: class {
    var presenter: ProfileEditScreenInteractorOutputProtocol? { get set }
    
}

protocol ProfileEditScreenInteractorOutputProtocol: class {

    func onError()
}
