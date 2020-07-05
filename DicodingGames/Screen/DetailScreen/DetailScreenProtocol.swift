//
//  DetailScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit


protocol DetailScreenViewProtocol: class {
    var presenter: DetailScreenPresenterProtocol? { get set }
    
    func showGameDetail(with gameDetail: GameDetail)
    
    func showGameScreenshots(with gameScreenshots: GameDetailScreenshots)

    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol DetailScreenWireFrameProtocol: class {
    static func createDetailScreenModule(forGames gameId: Int?) -> UIViewController 
}

protocol DetailScreenPresenterProtocol: class {
    var view: DetailScreenViewProtocol? { get set }
    var interactor: DetailScreenInteractorInputProtocol? { get set }
    var wireFrame: DetailScreenWireFrameProtocol? { get set }
    
    var gameId : Int? { get set }
    
    func viewDidLoad()
}

protocol DetailScreenInteractorInputProtocol: class {
    var presenter: DetailScreenInteractorOutputProtocol? { get set }
    var detailRemoteDataManager: DetailRemoteDataManagerInputProtocol? { get set }
    
    func retrieveGameDetailData(gameId: Int)
    func retrieveGameDetailScreenshots(gameId: Int)
}

protocol DetailScreenInteractorOutputProtocol: class {
    func didRetrieveGameDetail(_ gameDetail: GameDetail)
    func didRetrieveGameDetailScreenshots(_ gameScreenshots: GameDetailScreenshots)

    func onError()
}
