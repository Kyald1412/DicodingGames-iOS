//
//  ProfileAcademyScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ProfileAcademyScreenWireframe {
    
    class func createProfileAcademyScreenModule() -> UIHostingController<ProfileAcademyScreenView>  {
                
        let interactor: ProfileAcademyScreenInteractorInputProtocol = ProfileAcademyScreenInteractor()
        let presenter: ProfileAcademyScreenPresenter = ProfileAcademyScreenPresenter(interactor: interactor)

        interactor.presenter = presenter
        
        let hostingController = UIHostingController(rootView: ProfileAcademyScreenView(presenter: presenter))

        return hostingController
    }
    
 
    
}
