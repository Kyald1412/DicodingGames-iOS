//
//  ProfileAcademyScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine

class ProfileAcademyScreenPresenter: ObservableObject {
    private let interactor: ProfileAcademyScreenInteractorInputProtocol
        
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ProfileAcademyScreenInteractorInputProtocol) {
        self.interactor = interactor
        
    }
    
    
}

extension ProfileAcademyScreenPresenter: ProfileAcademyScreenInteractorOutputProtocol {
    
    func onError() {
        
    }
    

}
