//
//  GameListScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine

class GameListScreenPresenter: ObservableObject {
    private let interactor: GameListScreenInteractorInputProtocol
    
    @Published var gameList : [Results] = []
    @Published var title: String = ""
    var query: [String:String] = [:]

    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: GameListScreenInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    func onGameList(query: [String:String]) {
        interactor.retrieveGameListData(query: query, page: 1)
    }
    
}

extension GameListScreenPresenter: GameListScreenInteractorOutputProtocol {
    func didRetrieveGameList(_ gameList: GameModel) {
        self.gameList = gameList.results!
    }
    
    func onError() {
        
    }
    

}
