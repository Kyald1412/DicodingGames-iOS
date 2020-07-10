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
    var favoriteDataManager: FavoriteLocalDataManagerInputProtocol?
    
    func retrieveLocalFavoriteCount() {
        
        DispatchQueue.main.async { //make sure all UI updates are on the main thread.
            
            do {
                let isFavorite = try self.favoriteDataManager?.retrieveFavoriteGamesCount() ?? false
                
                self.presenter?.didRetrieveFavoriteGamesCount(isFavorite)
                return
            } catch  {
                
            }
            
        }
//        presenter?.didRetrieveFavoriteGamesCount(false)
        
    }
    
    func retrievePopularNowGamesData() {
        homeRemoteDataManager?.retrievePopularNowGamesData()
    }
    
    func retrieveUpcomingGamesData() {
        homeRemoteDataManager?.retrieveUpcomingGamesData()
    }
    
    func retrieveGamesData(size: Int) {
        homeRemoteDataManager?.retrieveGamesData(size: size)
    }
    
    func retrieveNewReleaseGamesData() {
        homeRemoteDataManager?.retrieveNewReleaseGamesData()
    }
    
}

extension HomeScreenInteractor: HomeRemoteDataManagerOutputProtocol {
    func onRetrieveNewReleaseGamesData(_ gameModel: GameModel) {
        presenter?.didRetrieveNewReleaseGamesData(gameModel)
    }
    
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
