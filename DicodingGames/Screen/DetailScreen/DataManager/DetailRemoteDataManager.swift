//
//  DetailRemoteDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: DetailRemoteDataManagerOutputProtocol? { get set }
    func retrieveGameDetailData(gameId: Int)
    func retrieveGameSuggestedData(gameId: Int)
    func retrieveGameDetailScreenshots(gameId: Int)
}

protocol DetailRemoteDataManagerOutputProtocol: class {
    func onGameDetailRetrieved(_ gameDetail: GameDetail)
    func onGameSuggestedRetrieved(_ suggestedGame: GameModel)
    func onGameDetailScreenshotRetrieved(_ gameScreenShot: GameDetailScreenshots)
    func onError()
}


class DetailRemoteDataManager:DetailRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DetailRemoteDataManagerOutputProtocol?
  
    func retrieveGameDetailData(gameId: Int) {
           
           let url = "\(Endpoints.Games.detail.url)\(gameId)"
           
           AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GameDetail.self) { (response) in
                   
                   switch response.result {
                   case .success(let games):
                       self.remoteRequestHandler?.onGameDetailRetrieved(games)
                   case .failure(let error):
                       print(error.localizedDescription)
                       self.remoteRequestHandler?.onError()
                       
                   }
           }
       }
    
    func retrieveGameSuggestedData(gameId: Int) {
           
           let url = "\(Endpoints.Games.detail.url)\(gameId)/suggested"
           
           AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GameModel.self) { (response) in
                   
                   switch response.result {
                   case .success(let games):
                       self.remoteRequestHandler?.onGameSuggestedRetrieved(games)
                   case .failure(let error):
                       print(error.localizedDescription)
                       self.remoteRequestHandler?.onError()
                       
                   }
           }
       }
    
    func retrieveGameDetailScreenshots(gameId: Int) {
           
           let url = "\(Endpoints.Games.detail.url)\(gameId)/screenshots"
           
           AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GameDetailScreenshots.self) { (response) in
                   
                   switch response.result {
                   case .success(let games):
                       self.remoteRequestHandler?.onGameDetailScreenshotRetrieved(games)
                   case .failure(let error):
                       print(error.localizedDescription)
                       self.remoteRequestHandler?.onError()
                       
                   }
           }
       }
    
}
