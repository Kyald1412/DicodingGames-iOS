//
//  FavoriteScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine

class FavoriteScreenPresenter: ObservableObject {
    private let interactor: FavoriteScreenInteractorInputProtocol
    
    @Published var gameFavorites : [FavoriteGames] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: FavoriteScreenInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    func onGameFavorite() {
        interactor.retrieveGameFavoriteData()
    }
    func onGameDelete(id: Int) {
        interactor.deleteGameFavoriteData(gameId: id)
    }
    
}

extension FavoriteScreenPresenter: FavoriteScreenInteractorOutputProtocol {
    func didRetrieveGameFavorite(_ gameFavorites: [FavoriteGames]) {
        self.gameFavorites = gameFavorites
    }
    
    func onError() {
        
    }
    

}
