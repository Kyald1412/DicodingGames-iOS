//
//  GameListRemoteDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GameListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: GameListRemoteDataManagerOutputProtocol? { get set }
    func retrieveGameListData(query: [String: String])
}

protocol GameListRemoteDataManagerOutputProtocol: class {
    func onGameListRetrieved(_ gameList: GameModel)
    func onError()
}

class GameListRemoteDataManager: GameListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: GameListRemoteDataManagerOutputProtocol?
    
    func retrieveGameListData(query: [String: String]) {
        
        var url = Endpoints.Games.allgames.url
        var parameters: [String: String] = [:]
        
        if let queryUrl = query["url"] {
            url = queryUrl
        } else {
            parameters = query
        }
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: GameModel.self) { (response) in
                
                switch response.result {
                case .success(let games):
                    self.remoteRequestHandler?.onGameListRetrieved(games)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.remoteRequestHandler?.onError()
                    
                }
        }
    }
    
}
