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
            let favoriteLocalDataManager: FavoriteLocalDataManagerInputProtocol = FavoriteLocalDataManager()
            let detailRemoteDataManager: DetailRemoteDataManagerInputProtocol = DetailRemoteDataManager()
            let wireFrame: DetailScreenWireFrameProtocol = DetailScreenWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.gameId = gameId
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.favoriteDataManager = favoriteLocalDataManager
            interactor.detailRemoteDataManager = detailRemoteDataManager
            detailRemoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
        
    func presentDetailScreen(from view: DetailScreenViewProtocol, games: Int) {
        let detailScreenViewController = DetailScreenWireFrame.createDetailScreenModule(forGames: games)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailScreenViewController, animated: true)
        }
        
    }
    
    func presentGameListScreen(from view: DetailScreenViewProtocol, gameId: Int) {

        let parameters = ["url": "\(Endpoints.Games.detail.url)\(gameId)/suggested?page_size=10"]

        let hostingController = GameListScreenWireframe.createGameListScreenModule(title: "You might also like", query: parameters)
        
        hostingController.rootView.onDismiss = {
            hostingController.dismiss(animated: true, completion: nil)
        }
        
        hostingController.rootView.onGameDidTap = { dataReturned in
            hostingController.dismiss(animated: true, completion: nil)
            self.presentDetailScreen(from: view, games: dataReturned)
        }
        
        if let sourceView = view as? UIViewController {
            hostingController.modalPresentationStyle = .fullScreen
            sourceView.navigationController?.present(hostingController, animated: true, completion: nil)
        }
        
    }
    
}
