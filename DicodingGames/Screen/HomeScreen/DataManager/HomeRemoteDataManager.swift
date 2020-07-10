//
//  HomeRemoteDataManager.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol HomeRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func retrieveGamesData(size: Int)
    func retrieveUpcomingGamesData()
    func retrievePopularNowGamesData()
    func retrieveNewReleaseGamesData()
}

protocol HomeRemoteDataManagerOutputProtocol: class {
    func onGamesRetrieved(_ gameModel: GameModel)
    func onUpcomingGamesRetrieved(_ gameModel: GameModel)
    func onRetrievePopularNowGamesData(_ gameModel: GameModel)
    func onRetrieveNewReleaseGamesData(_ gameModel: GameModel)
    
    func onError()
}


class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    func retrieveUpcomingGamesData() {
        
        let parameters = ["dates":"\(getDateWithYearModify(year: 0)),\(getDateWithYearModify(year:5))", "ordering":"-added","page_size":"10"]
        
        AF.request(Endpoints.Games.allgames.url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: GameModel.self) { (response) in
                
                switch response.result {
                case .success(let games):
                    self.remoteRequestHandler?.onUpcomingGamesRetrieved(games)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.remoteRequestHandler?.onError()
                    
                }
        }
    }

    
    func retrievePopularNowGamesData() {
                
        let parameters = ["dates":"\(getDateWithYearModify(year: -1)),\(getDateWithYearModify(year:0))", "ordering":"-rating,released","page_size":"10"]

        AF.request(Endpoints.Games.allgames.url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: GameModel.self) { (response) in
                
                switch response.result {
                case .success(let games):
                    self.remoteRequestHandler?.onRetrievePopularNowGamesData(games)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.remoteRequestHandler?.onError()
                    
                }
        }
    }
    
    func retrieveNewReleaseGamesData() {
                   
           let parameters = ["dates":"\(getDateWithYearModify(year: -1)),\(getDateWithYearModify(year:0))", "ordering":"-released","page_size":"10"]

           AF.request(Endpoints.Games.allgames.url, method: .get, parameters: parameters)
               .validate()
               .responseDecodable(of: GameModel.self) { (response) in
                   
                   switch response.result {
                   case .success(let games):
                       self.remoteRequestHandler?.onRetrieveNewReleaseGamesData(games)
                   case .failure(let error):
                       print(error.localizedDescription)
                       self.remoteRequestHandler?.onError()
                       
                   }
           }
       }
    
    func retrieveGamesData(size: Int) {
        
        let parameters = ["page_size":"\(size)"]
        
        AF.request(Endpoints.Games.allgames.url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: GameModel.self) { (response) in
                
                switch response.result {
                case .success(let games):
                    self.remoteRequestHandler?.onGamesRetrieved(games)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.remoteRequestHandler?.onError()
                    
                }
        }
        
    }
    
}
