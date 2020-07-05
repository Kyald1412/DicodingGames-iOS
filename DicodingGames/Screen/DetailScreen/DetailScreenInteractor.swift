//
//  DetailScreenInteractor.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation

class DetailScreenInteractor: DetailScreenInteractorInputProtocol {
    
    weak var presenter: DetailScreenInteractorOutputProtocol?
    var detailRemoteDataManager: DetailRemoteDataManagerInputProtocol?
    
    func retrieveGameDetailData(gameId: Int) {
        detailRemoteDataManager?.retrieveGameDetailData(gameId: gameId)
    }
    
    func retrieveGameDetailScreenshots(gameId: Int) {
        detailRemoteDataManager?.retrieveGameDetailScreenshots(gameId: gameId)
    }
    
}

extension DetailScreenInteractor: DetailRemoteDataManagerOutputProtocol {
    func onGameDetailScreenshotRetrieved(_ gameScreenShot: GameDetailScreenshots) {
        presenter?.didRetrieveGameDetailScreenshots(gameScreenShot)
    }
    
    func onGameDetailRetrieved(_ gameDetail: GameDetail) {
        presenter?.didRetrieveGameDetail(gameDetail)
    }
    
    
    func onError() {
        presenter?.onError()
    }
    
}
