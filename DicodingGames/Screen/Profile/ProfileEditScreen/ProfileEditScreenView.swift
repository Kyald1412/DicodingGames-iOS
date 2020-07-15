//
//  ProfileEditScreenView.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import PKHUD
import Closures
import SwiftUI
import Combine
import SDWebImageSwiftUI
import imageOptClient
import Foundation

typealias onProfileEditScreenDismiss = () ->()

struct ProfileEditScreenView: View {
    
    @ObservedObject var presenter: ProfileEditScreenPresenter
    var onDismiss: onProfileEditScreenDismiss?
    
    @State var isSaveDisabled = false

    init(presenter: ProfileEditScreenPresenter) {
        self.presenter = presenter
        self.presenter.onDismiss = onDismiss
        
        self.presenter.onShowProfileData()
        
    }
    
    var body: some View {
        
        return VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Button(action: {
                        self.performDismiss()
                    }) {
                        Image("arrow_left_navigation")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                    }
                    
                    Text("Profile Edit")
                        .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                        
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    
                    Button(action: {
                        
                        self.performDismiss()
                        self.presenter.onUpdateProfileData()
                        
                    }) {
                        Image("ic_confirm")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))                .disabled(self.isSaveDisabled)

                }
                
                VStack {
                    
                    if presenter.image != nil {
                        presenter.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150, alignment: .center)
                            .clipShape(Circle())
                            .onTapGesture {  self.presenter.showImagePicker.toggle() }
                    } else {
                        Image("dicoding_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150, alignment: .center)
                            .clipShape(Circle())
                            .onTapGesture {  self.presenter.showImagePicker.toggle() }
                    }
                    
                    Text("Change Profile Photo")
                        .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center).foregroundColor(Color.blue)
                        
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                }
                
                VStack(alignment: .leading) {
                    Text("Name").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                    TextField("Your name ...", text:  $presenter.name).validation(presenter.nameValidation).accentColor(Color.white).foregroundColor(Color.white)
                    Divider().background(Color.white)
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Category").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                    TextField("Category ...", text:  $presenter.category).validation(presenter.categoryValidation).accentColor(Color.white).foregroundColor(Color.white)
                    Divider().background(Color.white)
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Bio").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                    TextField("Your Bio ...", text:  $presenter.bio).validation(presenter.bioValidation).accentColor(Color.white).foregroundColor(Color.white)
                    Divider().background(Color.white)
                }.padding()
                
                Spacer()
                
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).background(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                
            )).onReceive(presenter.allValidation) { validation in
                self.isSaveDisabled = !validation.isSuccess}

            
        .sheet(isPresented: $presenter.showImagePicker, onDismiss: loadImage) { ImagePicker(image: self.$presenter.inputImage) }
        
        
    }
    
    func loadImage() {
        guard let inputImage = presenter.inputImage else { return }
        presenter.image = Image(uiImage: inputImage)
    }
    
    func performDismiss(){
        guard let dismiss = onDismiss else {return}
        dismiss()
    }
    
}


struct ProfileEditScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let interactor: ProfileEditScreenInteractorInputProtocol = ProfileEditScreenInteractor()
        //        let profileEditLocalDataManager: ProfileEditLocalDataManagerInputProtocol = ProfileEditLocalDataManager()
        //        interactor.profileEditLocalDataManager = profileEditLocalDataManager
        
        let presenter: ProfileEditScreenPresenter = ProfileEditScreenPresenter(interactor: interactor)
        
        return NavigationView {
            ProfileEditScreenView(presenter: presenter)
        }
    }
}
