//
//  HomeScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol HomeScreenViewProtocol: class {
    var presenter: HomeScreenPresenterProtocol? { get set }
    
    func showBannerGames(with games: GameModel)
    
    func showUpcomingGames(with games: GameModel)
    
    func showPopularNowGames(with games: GameModel)

    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol HomeScreenWireFrameProtocol: class {
    static func createHomeScreenModule(homeScreenRef: HomeScreenView)
    func presentProfileScreen(from view: HomeScreenViewProtocol)
    func presentSearchScreen(from view: HomeScreenViewProtocol)
    func presentDetailScreen(from view: HomeScreenViewProtocol, games: Int)
}

protocol HomeScreenPresenterProtocol: class {
    var view: HomeScreenViewProtocol? { get set }
    var interactor: HomeScreenInteractorInputProtocol? { get set }
    var wireFrame: HomeScreenWireFrameProtocol? { get set }
    
    func showProfileView()
    func showSearchView()
    func showDetailScreenView(_ games: Int)
    func viewDidLoad()
}

protocol HomeScreenInteractorInputProtocol: class {
    var presenter: HomeScreenInteractorOutputProtocol? { get set }
    var homeRemoteDataManager: HomeRemoteDataManagerInputProtocol? { get set }
    
    func retrieveGamesData(size: Int)
    func retrievePopularNowGamesData()
    func retrieveUpcomingGamesData()
}

protocol HomeScreenInteractorOutputProtocol: class {
    func didRetrieveGames(_ games: GameModel)
    func didRetrievePopularNowGames(_ games: GameModel)
    func didRetrieveUpcomingGames(_ games: GameModel)

    func onError()
}
