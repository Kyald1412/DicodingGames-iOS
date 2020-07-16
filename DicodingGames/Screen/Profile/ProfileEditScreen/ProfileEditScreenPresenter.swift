//
//  ProfileEditScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 02/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
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
        
    lazy var nameValidation: ValidationPublisher = {
        $name.nonEmptyValidator("Name must be provided")
    }()
    
    lazy var categoryValidation: ValidationPublisher = {
        $category.nonEmptyValidator("Category must be provided")
    }()
    
    lazy var bioValidation: ValidationPublisher = {
        $bio.nonEmptyValidator("Bio must be provided")
    }()
    
    lazy var allValidation: ValidationPublisher = {
                
        Combine.Publishers.Merge3(
            nameValidation,
            categoryValidation,
            bioValidation
        ).map { v1 in
            return [v1].allSatisfy { $0.isSuccess } ? .success : .failure(message: "")
        }.eraseToAnyPublisher()
    }()
        

    var cancellables = Set<AnyCancellable>()
    
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
        
        guard let dismiss = onDismiss else {return}
        dismiss()
    }
    
    func didReceiveProfileData(profile: Profile){
                
        guard let image = UIImage(named: "me") else { return }
        
        self.name = profile.name
        self.category = profile.category
        self.bio = profile.bio
        self.image = Image(uiImage: UIImage.init(data: profile.photo) ?? image )
        self.inputImage = UIImage.init(data: profile.photo) ?? image

    }
    
    func onError() {
        
    }
    

}
