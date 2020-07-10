//
//  FavoriteScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteScreenViewProtocol: class {
    var presenter: FavoriteScreenPresenterProtocol? { get set }
    
    func showGameFavorite(with gameFavorites: [FavoriteGames])
    
    func showError()
}

protocol FavoriteScreenWireFrameProtocol: class {
    static func createFavoriteScreenModule(forGames gameId: Int?) -> UIViewController
}

protocol FavoriteScreenPresenterProtocol: class {
    var view: FavoriteScreenViewProtocol? { get set }
    var interactor: FavoriteScreenInteractorInputProtocol? { get set }
    var wireFrame: FavoriteScreenWireFrameProtocol? { get set }
        
    func viewDidLoad()
}

protocol FavoriteScreenInteractorInputProtocol: class {
    var presenter: FavoriteScreenInteractorOutputProtocol? { get set }
    var favoriteLocalDataManager: FavoriteLocalDataManagerInputProtocol? { get set }
    
    func retrieveGameFavoriteData()
    func deleteGameFavoriteData(gameId: Int)
}

protocol FavoriteScreenInteractorOutputProtocol: class {
    func didRetrieveGameFavorite(_ gameFavorites: [FavoriteGames])

    func onError()
}
