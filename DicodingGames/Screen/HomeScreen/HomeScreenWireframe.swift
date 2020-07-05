//
//  HomeScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class HomeScreenWireFrame: HomeScreenWireFrameProtocol {
   
    
    class func createHomeScreenModule(homeScreenRef: HomeScreenView) {
        
        let presenter: HomeScreenPresenterProtocol & HomeScreenInteractorOutputProtocol = HomeScreenPresenter()
        let interactor: HomeScreenInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeScreenInteractor()
        let homeRemoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
        let wireFrame: HomeScreenWireFrameProtocol = HomeScreenWireFrame()
        
        homeScreenRef.presenter = presenter
        presenter.view = homeScreenRef
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.homeRemoteDataManager = homeRemoteDataManager
        homeRemoteDataManager.remoteRequestHandler = interactor
        
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    func presentProfileScreen(from view: HomeScreenViewProtocol) {
        let profileViewController = ProfileScreenWireFrame.createProfileScreenModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    
    func presentDetailScreen(from view: HomeScreenViewProtocol, games: Int) {
        let detailScreenViewController = DetailScreenWireFrame.createDetailScreenModule(forGames: games)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailScreenViewController, animated: true)
        }
        
        
    }
        
    func presentSearchScreen(from view: HomeScreenViewProtocol) {
        
        let hostingController = SearchScreenWireframe.createSearchScreenModule()
        
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
