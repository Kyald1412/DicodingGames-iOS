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
    
    func showFavoriteGamesCount(with favorite: Bool)
    
    func showBannerGames(with games: GameModel)
    
    func showUpcomingGames(with games: GameModel)
    
    func showPopularNowGames(with games: GameModel)
    
    func showNewReleasedGames(with games: GameModel)

    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol HomeScreenWireFrameProtocol: class {
    static func createHomeScreenModule(homeScreenRef: HomeScreenView)
    func presentProfileScreen(from view: HomeScreenViewProtocol)
    func presentSearchScreen(from view: HomeScreenViewProtocol)
    func presentFavoriteScreen(from view: HomeScreenViewProtocol)
    func presentDetailScreen(from view: HomeScreenViewProtocol, games: Int)
    func presentGameListScreen(from view: HomeScreenViewProtocol)
    
}

protocol HomeScreenPresenterProtocol: class {
    var view: HomeScreenViewProtocol? { get set }
    var interactor: HomeScreenInteractorInputProtocol? { get set }
    var wireFrame: HomeScreenWireFrameProtocol? { get set }
    
    func showProfileView()
    func showSearchView()
    func showFavoriteScreenView()
    func showDetailScreenView(_ games: Int)
    func showGameListScreen()

    func viewDidLoad()
}

protocol HomeScreenInteractorInputProtocol: class {
    var presenter: HomeScreenInteractorOutputProtocol? { get set }
    var homeRemoteDataManager: HomeRemoteDataManagerInputProtocol? { get set }
    var favoriteDataManager: FavoriteLocalDataManagerInputProtocol? { get set }

    func retrieveLocalFavoriteCount()
    func retrieveGamesData(size: Int)
    func retrievePopularNowGamesData()
    func retrieveUpcomingGamesData()
    func retrieveNewReleaseGamesData()
    
}

protocol HomeScreenInteractorOutputProtocol: class {
    func didRetrieveGames(_ games: GameModel)
    func didRetrievePopularNowGames(_ games: GameModel)
    func didRetrieveUpcomingGames(_ games: GameModel)
    func didRetrieveNewReleaseGamesData(_ games: GameModel)
    func didRetrieveFavoriteGamesCount(_ favorite: Bool)

    func onError()
}
