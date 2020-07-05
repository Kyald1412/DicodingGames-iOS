//
//  DetailScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation


class DetailScreenPresenter: DetailScreenPresenterProtocol {
    var gameId: Int?
    
    weak var view: DetailScreenViewProtocol?
    var interactor: DetailScreenInteractorInputProtocol?
    var wireFrame: DetailScreenWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        
        interactor?.retrieveGameDetailData(gameId: gameId ?? 0)
        interactor?.retrieveGameDetailScreenshots(gameId: gameId ?? 0)

    }
    
}

extension DetailScreenPresenter: DetailScreenInteractorOutputProtocol {
    func didRetrieveGameDetailScreenshots(_ gameScreenshots: GameDetailScreenshots) {
        view?.hideLoading()
        view?.showGameScreenshots(with: gameScreenshots)
    }
    
    func didRetrieveGameDetail(_ gameDetail: GameDetail) {
        view?.hideLoading()
        view?.showGameDetail(with: gameDetail)
        
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}
