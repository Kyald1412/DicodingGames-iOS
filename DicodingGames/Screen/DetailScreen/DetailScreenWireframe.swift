//
//  DetailScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

class DetailScreenWireFrame: DetailScreenWireFrameProtocol {
    
    class func createDetailScreenModule(forGames gameId: Int?) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailScreenView")
        if let view = viewController as? DetailScreenView {
            let presenter: DetailScreenPresenterProtocol & DetailScreenInteractorOutputProtocol = DetailScreenPresenter()
            let interactor: DetailScreenInteractorInputProtocol & DetailRemoteDataManagerOutputProtocol = DetailScreenInteractor()
            let detailRemoteDataManager: DetailRemoteDataManagerInputProtocol = DetailRemoteDataManager()
            let wireFrame: DetailScreenWireFrameProtocol = DetailScreenWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.gameId = gameId
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.detailRemoteDataManager = detailRemoteDataManager
            detailRemoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
