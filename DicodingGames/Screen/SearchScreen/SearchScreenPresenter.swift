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
    
    @Published var gameSearch: [Results] = []
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: SearchScreenInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    func onGameSearch(gameName: String) {
        isLoading = true
        isEmpty = false
        interactor.retrieveGameSearchData(gameName: gameName, page: 1)
    }
    
}

extension SearchScreenPresenter: SearchScreenInteractorOutputProtocol {
    func didRetrieveGameSearch(_ gameSearch: GameSearch) {
        isLoading = false
        self.gameSearch = gameSearch.results!
        if self.gameSearch.count == 0 {
            isEmpty = true
        }
    }
    
    func onError() {
        isLoading = false
    }

}
