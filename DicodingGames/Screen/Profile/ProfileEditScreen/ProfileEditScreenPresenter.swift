//
//  ProfileEditScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

class ProfileEditScreenPresenter: ObservableObject {
    private let interactor: ProfileEditScreenInteractorInputProtocol
        
    var onDismiss: onProfileEditScreenDismiss?

    @Published var name: String = ""
    @Published var category: String = ""
    @Published var bio: String = ""
    
    // Image
    @Published var image: Image?
    @Published var showImagePicker = false
    @Published var inputImage: UIImage?
    

    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ProfileEditScreenInteractorInputProtocol) {
        self.interactor = interactor        
    }
    
    func onShowProfileData() {
        interactor.retrieveProfileData()
    }
    
    func onUpdateProfileData() {
        
        guard let image = UIImage(named: "me") else { return }
        let jpegData = image.jpegData(compressionQuality: 0.3)!
        
        interactor.updateProfileData(name: name, bio: bio, category: category, photo:self.inputImage?.jpegData(compressionQuality: 0.3) ?? jpegData)
    }
    
}

extension ProfileEditScreenPresenter: ProfileEditScreenInteractorOutputProtocol {
    func didSuccessUpdateData() {
        print("asdsadasd")
        
        guard let dismiss = onDismiss else {return}
        dismiss()
    }
    
    func didReceiveProfileData(profile: Profile){
        
        print("rpsdasdsadiohas \(profile)")
        
        guard let image = UIImage(named: "me") else { return }

        self.name = profile.name
        self.category = profile.category
        self.bio = profile.bio
        self.image = Image(uiImage: UIImage.init(data: profile.photo) ?? image )
        print(self.name)

    }
    
    func onError() {
        
    }
    

}
