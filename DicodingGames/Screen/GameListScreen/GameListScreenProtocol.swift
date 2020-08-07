//
//  GameListScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol GameListScreenViewProtocol: class {
    var presenter: GameListScreenPresenterProtocol? { get set }
    
    func showGameList(with gameList: GameModel)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol GameListScreenWireFrameProtocol: class {
    static func createGameListScreenModule(forGames gameId: Int?) -> UIViewController
}

protocol GameListScreenPresenterProtocol: class {
    var view: GameListScreenViewProtocol? { get set }
    var interactor: GameListScreenInteractorInputProtocol? { get set }
    var wireFrame: GameListScreenWireFrameProtocol? { get set }
    
    var gameId: Int? { get set }
    
    func viewDidLoad()
}

protocol GameListScreenInteractorInputProtocol: class {
    var presenter: GameListScreenInteractorOutputProtocol? { get set }
    var gameListRemoteDataManager: GameListRemoteDataManagerInputProtocol? { get set }
    
    func retrieveGameListData(query: [String: String])
}

protocol GameListScreenInteractorOutputProtocol: class {
    func didRetrieveGameList(_ gameList: GameModel)

    func onError()
}
