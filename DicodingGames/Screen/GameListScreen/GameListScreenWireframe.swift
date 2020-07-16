//
//  GameListScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class GameListScreenWireframe {
    
    class func createGameListScreenModule(title: String, query: [String:String]) -> UIHostingController<GameListScreenView>  {
                
        let interactor: GameListScreenInteractorInputProtocol & GameListRemoteDataManagerOutputProtocol = GameListScreenInteractor()
        let gameListRemoteDataManager: GameListRemoteDataManagerInputProtocol = GameListRemoteDataManager()
        let presenter: GameListScreenPresenter = GameListScreenPresenter(interactor: interactor)

        presenter.title = title
        presenter.query = query
        interactor.presenter = presenter
        interactor.gameListRemoteDataManager = gameListRemoteDataManager
        gameListRemoteDataManager.remoteRequestHandler = interactor
        
        let hostingController = UIHostingController(rootView: GameListScreenView(presenter: presenter))

        return hostingController
    }
    
 
    
}
