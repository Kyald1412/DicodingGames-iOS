//
//  ProfileEditScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ProfileEditScreenWireframe {
    
    class func createProfileEditScreenModule() -> UIHostingController<ProfileEditScreenView>  {
                
        let interactor: ProfileEditScreenInteractorInputProtocol = ProfileEditScreenInteractor()
        let presenter: ProfileEditScreenPresenter = ProfileEditScreenPresenter(interactor: interactor)

        interactor.presenter = presenter
        
        let hostingController = UIHostingController(rootView: ProfileEditScreenView(presenter: presenter))

        return hostingController
    }
    
 
    
}
