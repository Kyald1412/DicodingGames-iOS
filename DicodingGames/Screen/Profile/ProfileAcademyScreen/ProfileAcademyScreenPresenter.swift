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

    @Published var title: String = ""
    @Published var desc: String = ""
    
    // Image
    @Published var image: Image?
    @Published var showImagePicker = false
    @Published var inputImage: UIImage?
    
    var academyId = 0
    var isEditAcademy = false

    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ProfileAcademyScreenInteractorInputProtocol) {
        self.interactor = interactor
        
    }
    
    func onAcademyEdit(){
        interactor.retrieveAcademyDataById(id: academyId)
    }
    
    
    func editAcademyData(){
        guard let image = UIImage(named: "dicoding_logo") else { return }
        let jpegData = image.jpegData(compressionQuality: 0.3)!

        interactor.editAcademyData(id: academyId, title: title, description: desc, photo: self.inputImage?.jpegData(compressionQuality: 0.3) ?? jpegData)
    }
    
    func addAcademyData(){
        guard let image = UIImage(named: "dicoding_logo") else { return }
        let jpegData = image.jpegData(compressionQuality: 0.3)!
        interactor.addAcademyData(title: title, description: desc, photo: self.inputImage?.jpegData(compressionQuality: 0.3) ?? jpegData)
    }
    
    
}

extension ProfileAcademyScreenPresenter: ProfileAcademyScreenInteractorOutputProtocol {
    
    func onError() {
        
    }
    
    func didReceiveAcademyData(academy: Academy){
        
        guard let image = UIImage(named: "dicoding_logo") else { return }

        self.title = academy.name
        self.desc = academy.desc
        self.image = Image(uiImage: UIImage.init(data: academy.photo) ?? image )
        
    }


}
