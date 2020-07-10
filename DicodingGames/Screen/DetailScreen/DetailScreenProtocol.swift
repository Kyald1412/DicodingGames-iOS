//
//  DetailScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit


protocol DetailScreenViewProtocol: class {
    var presenter: DetailScreenPresenterProtocol? { get set }
    
    func showGameDetail(with gameDetail: GameDetail)

    func showGameSuggested(with gameDetail: GameModel)

    func checkMyFavorite(with isMyFavorite: Bool)

    func showGameScreenshots(with gameScreenshots: GameDetailScreenshots)

    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol DetailScreenWireFrameProtocol: class {
    static func createDetailScreenModule(forGames gameId: Int?) -> UIViewController
    
    func presentDetailScreen(from view: DetailScreenViewProtocol, games: Int)
    func presentGameListScreen(from view: DetailScreenViewProtocol, gameId: Int)

}

protocol DetailScreenPresenterProtocol: class {
    var view: DetailScreenViewProtocol? { get set }
    var interactor: DetailScreenInteractorInputProtocol? { get set }
    var wireFrame: DetailScreenWireFrameProtocol? { get set }
    
    var gameId : Int? { get set }
    
    func viewDidLoad()
    func showDetailScreen(gameId: Int)
    func showSuggestedGameList(gameId: Int)

}

protocol DetailScreenInteractorInputProtocol: class {
    var presenter: DetailScreenInteractorOutputProtocol? { get set }
    var detailRemoteDataManager: DetailRemoteDataManagerInputProtocol? { get set }
    var favoriteDataManager: FavoriteLocalDataManagerInputProtocol? { get set }
    
    func saveFavoriteGame(id: Int, title: String, desc: String, rating: String, imageUrl: String)
    func retrieveLocalFavorite(gameId: Int) -> Bool
    func deleteGameFavoriteData(gameId: Int)
    func retrieveGameDetailData(gameId: Int)
    func retrieveGameSuggestedData(gameId: Int)
    func retrieveGameDetailScreenshots(gameId: Int)
}

protocol DetailScreenInteractorOutputProtocol: class {
    func didRetrieveGameDetail(_ gameDetail: GameDetail)
    func didRetrieveGameSuggested(_ suggestedGame: GameModel)
    func didRetrieveGameDetailScreenshots(_ gameScreenshots: GameDetailScreenshots)

    func onError()
}
