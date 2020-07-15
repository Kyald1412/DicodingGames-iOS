//
//  DetailScreenInteractor.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

class DetailScreenInteractor: DetailScreenInteractorInputProtocol {


    weak var presenter: DetailScreenInteractorOutputProtocol?
    var detailRemoteDataManager: DetailRemoteDataManagerInputProtocol?
    var favoriteDataManager: FavoriteLocalDataManagerInputProtocol?
    
    func saveFavoriteGame(id: Int, title: String, desc: String, rating: String,release_date: String, imageUrl: String){
        do {
            try favoriteDataManager?.saveFavoriteGame(id: id, title: title, desc: desc, rating: rating,release_date: release_date, imageUrl: imageUrl)
        } catch  {
            
        }
    }
    
    func retrieveLocalFavorite(gameId: Int) -> Bool {
        do {
            return try favoriteDataManager?.retrieveFavoriteGamesById(gameId: gameId) ?? false

        } catch  {

        }
        
        return false
    }
    
    func deleteGameFavoriteData(gameId: Int) {
        
        DispatchQueue.main.async {
            do {
                try self.favoriteDataManager?.deleteFavoriteGame(id: gameId)
            } catch {
                self.presenter?.onError()
            }
        }
        
    }
    
    
    func retrieveGameDetailData(gameId: Int) {
        detailRemoteDataManager?.retrieveGameDetailData(gameId: gameId)
    }
    
    func retrieveGameDetailScreenshots(gameId: Int) {
        detailRemoteDataManager?.retrieveGameDetailScreenshots(gameId: gameId)
    }
    
    func retrieveGameSuggestedData(gameId: Int) {
        detailRemoteDataManager?.retrieveGameSuggestedData(gameId: gameId)
    }
    
}

extension DetailScreenInteractor: DetailRemoteDataManagerOutputProtocol {
    func onGameSuggestedRetrieved(_ suggestedGame: GameModel) {
        presenter?.didRetrieveGameSuggested(suggestedGame)
    }
    
    func onGameDetailScreenshotRetrieved(_ gameScreenShot: GameDetailScreenshots) {
        presenter?.didRetrieveGameDetailScreenshots(gameScreenShot)
    }
    
    func onGameDetailRetrieved(_ gameDetail: GameDetail) {
        presenter?.didRetrieveGameDetail(gameDetail)
    }
    
    
    func onError() {
        presenter?.onError()
    }
    
}
