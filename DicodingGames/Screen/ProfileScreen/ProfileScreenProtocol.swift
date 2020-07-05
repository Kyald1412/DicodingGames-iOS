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
  
}

protocol ProfileScreenWireFrameProtocol: class {
    static func createProfileScreenModule() -> UIViewController
}

protocol ProfileScreenPresenterProtocol: class {
    var view: ProfileScreenViewProtocol? { get set }
    var wireFrame: ProfileScreenWireFrameProtocol? { get set }
    
    func viewDidLoad()
}
