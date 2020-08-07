//
//  FavoriteScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Combine
import Foundation

class FavoriteScreenInteractor: FavoriteScreenInteractorInputProtocol {
    
    weak var presenter: FavoriteScreenInteractorOutputProtocol?
    var favoriteLocalDataManager: FavoriteLocalDataManagerInputProtocol?
    
    func retrieveGameFavoriteData() {

        do {
            if let favoriteList = try favoriteLocalDataManager?.retrieveFavoriteGamesList() {
                presenter?.didRetrieveGameFavorite(favoriteList)
            } else {
                presenter?.didRetrieveGameFavorite([])
            }
            
        } catch {
            presenter?.didRetrieveGameFavorite([])
        }
    }
    
    func deleteGameFavoriteData(gameId: Int) {

        DispatchQueue.main.async {
            do {
                try self.favoriteLocalDataManager?.deleteFavoriteGame(id: gameId)
            } catch {
                self.presenter?.onError()
            }
        }
        
        DispatchQueue.main.async {
            self.retrieveGameFavoriteData()
        }
    }
    
}
