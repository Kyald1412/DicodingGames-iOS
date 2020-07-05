//
//  ProfileScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

class ProfileScreenWireFrame: ProfileScreenWireFrameProtocol {
    
    class func createProfileScreenModule() -> UIViewController  {
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileScreenView")
        
        if let view = viewController as? ProfileScreenView {
            
            let presenter: ProfileScreenPresenterProtocol = ProfileScreenPresenter()
            let wireFrame: ProfileScreenWireFrameProtocol = ProfileScreenWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame

            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
