//
//  GameListScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Combine

class GameListScreenInteractor: GameListScreenInteractorInputProtocol {
    
    weak var presenter: GameListScreenInteractorOutputProtocol?
    var gameListRemoteDataManager: GameListRemoteDataManagerInputProtocol?
    
    func retrieveGameListData(query: [String:String]) {

        gameListRemoteDataManager?.retrieveGameListData(query: query)
    }
    
}

extension GameListScreenInteractor: GameListRemoteDataManagerOutputProtocol {

    func onGameListRetrieved(_ gameList: GameModel) {
        presenter?.didRetrieveGameList(gameList)
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
