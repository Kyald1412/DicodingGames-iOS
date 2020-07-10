//
//  SearchScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Combine

class SearchScreenInteractor: SearchScreenInteractorInputProtocol {
    
    weak var presenter: SearchScreenInteractorOutputProtocol?
    var searchRemoteDataManager: SearchRemoteDataManagerInputProtocol?
    
    func retrieveGameSearchData(gameName: String, page: Int) {
        
//        print("PRESENETE \(presenter)")
//        print("favorite \(searchRemoteDataManager)")

        searchRemoteDataManager?.retrieveGameSearchData(gameName: gameName, page: page)
    }
    
}

extension SearchScreenInteractor: SearchRemoteDataManagerOutputProtocol {

    func onGameSearchRetrieved(_ gameSearch: GameSearch) {
        presenter?.didRetrieveGameSearch(gameSearch)
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
