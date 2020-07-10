//
//  ProfileEditScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine

class ProfileEditScreenPresenter: ObservableObject {
    private let interactor: ProfileEditScreenInteractorInputProtocol
        
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ProfileEditScreenInteractorInputProtocol) {
        self.interactor = interactor
        
    }
    
    
}

extension ProfileEditScreenPresenter: ProfileEditScreenInteractorOutputProtocol {
    
    func onError() {
        
    }
    

}
