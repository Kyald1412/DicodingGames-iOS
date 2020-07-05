//
//  HomeScreenInteractor.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

class HomeScreenInteractor: HomeScreenInteractorInputProtocol {
    
    weak var presenter: HomeScreenInteractorOutputProtocol?
    var homeRemoteDataManager: HomeRemoteDataManagerInputProtocol?
    
    func retrievePopularNowGamesData() {
        homeRemoteDataManager?.retrievePopularNowGamesData()
    }
    
    func retrieveUpcomingGamesData() {
        homeRemoteDataManager?.retrieveUpcomingGamesData()
    }
    
    func retrieveGamesData(size: Int) {
        homeRemoteDataManager?.retrieveGamesData(size: size)
    }
    
}

extension HomeScreenInteractor: HomeRemoteDataManagerOutputProtocol {
    
    func onUpcomingGamesRetrieved(_ gameModel: GameModel) {
        presenter?.didRetrieveUpcomingGames(gameModel)
    }
    
    func onRetrievePopularNowGamesData(_ gameModel: GameModel) {
        presenter?.didRetrievePopularNowGames(gameModel)
    }
    
    func onGamesRetrieved(_ gameModel: GameModel) {
        presenter?.didRetrieveGames(gameModel)
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
