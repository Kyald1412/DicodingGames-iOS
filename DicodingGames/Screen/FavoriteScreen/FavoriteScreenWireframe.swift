//
//  FavoriteScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class FavoriteScreenWireframe {
    
    class func createFavoriteScreenModule() -> UIHostingController<FavoriteScreenView> {
                
        let interactor: FavoriteScreenInteractorInputProtocol = FavoriteScreenInteractor()
        let favoriteLocalDataManager: FavoriteLocalDataManagerInputProtocol = FavoriteLocalDataManager()
        let presenter: FavoriteScreenPresenter = FavoriteScreenPresenter(interactor: interactor)
        
        interactor.presenter = presenter
        interactor.favoriteLocalDataManager = favoriteLocalDataManager
        
        let hostingController = UIHostingController(rootView: FavoriteScreenView(presenter: presenter))

        return hostingController
    }
    
}
