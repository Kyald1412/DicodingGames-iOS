//
//  SearchRemoteDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol SearchRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
    func retrieveGameSearchData(gameName: String, page: Int)
}

protocol SearchRemoteDataManagerOutputProtocol: class {
    func onGameSearchRetrieved(_ gameSearch: GameSearch)
    func onError()
}

class SearchRemoteDataManager:SearchRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    
    func retrieveGameSearchData(gameName: String, page: Int) {
        
        let parameters = ["page":"\(page)","search":"\(gameName)","page_size":"10"]
        
        AF.request(Endpoints.Games.allgames.url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: GameSearch.self) { (response) in
                
                switch response.result {
                case .success(let games):
                    self.remoteRequestHandler?.onGameSearchRetrieved(games)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.remoteRequestHandler?.onError()
                    
                }
        }
    }
    
    
}
