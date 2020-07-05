//
//  SearchScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine

class SearchScreenPresenter: ObservableObject {
    private let interactor: SearchScreenInteractorInputProtocol
    
    @Published var gameSearch : [Results] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: SearchScreenInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    func onGameSearch(gameName: String) {
        interactor.retrieveGameSearchData(gameName: gameName, page: 1)
    }
    
}

extension SearchScreenPresenter: SearchScreenInteractorOutputProtocol {
    func didRetrieveGameSearch(_ gameSearch: GameSearch) {
        self.gameSearch = gameSearch.results!
    }
    
    func onError() {
        
    }
    

}
