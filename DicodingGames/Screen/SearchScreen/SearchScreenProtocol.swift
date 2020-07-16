//
//  SearchScreenProtocol.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

protocol SearchScreenViewProtocol: class {
    var presenter: SearchScreenPresenterProtocol? { get set }
    
    func showGameSearch(with gameSearch: GameSearch)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol SearchScreenWireFrameProtocol: class {
    static func createSearchScreenModule(forGames gameId: Int?) -> UIViewController
}

protocol SearchScreenPresenterProtocol: class {
    var view: SearchScreenViewProtocol? { get set }
    var interactor: SearchScreenInteractorInputProtocol? { get set }
    var wireFrame: SearchScreenWireFrameProtocol? { get set }
    
    var gameId : Int? { get set }
    
    func viewDidLoad()
}

protocol SearchScreenInteractorInputProtocol: class {
    var presenter: SearchScreenInteractorOutputProtocol? { get set }
    var searchRemoteDataManager: SearchRemoteDataManagerInputProtocol? { get set }
    
    func retrieveGameSearchData(gameName: String, page: Int)
}

protocol SearchScreenInteractorOutputProtocol: class {
    func didRetrieveGameSearch(_ gameSearch: GameSearch)

    func onError()
}
