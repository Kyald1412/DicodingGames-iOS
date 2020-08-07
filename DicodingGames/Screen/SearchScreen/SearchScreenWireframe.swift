//
//  SearchScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SearchScreenWireframe {
    
    class func createSearchScreenModule() -> UIHostingController<SearchScreenView> {
                
        let interactor: SearchScreenInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchScreenInteractor()
        let searchRemoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager()
        let presenter: SearchScreenPresenter = SearchScreenPresenter(interactor: interactor)

        interactor.presenter = presenter
        interactor.searchRemoteDataManager = searchRemoteDataManager
        searchRemoteDataManager.remoteRequestHandler = interactor
        
        let hostingController = UIHostingController(rootView: SearchScreenView(presenter: presenter))

        return hostingController
    }
    
}
