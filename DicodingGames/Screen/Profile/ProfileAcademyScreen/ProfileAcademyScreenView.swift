//
//  ProfileAcademyScreenView.swift
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

typealias onProfileAcademyScreenDismiss = () ->()

struct ProfileAcademyScreenView: View {
    
    @ObservedObject var presenter: ProfileAcademyScreenPresenter
    var onDismiss: onFavoriteScreenDismiss?
    
    @State var isSaveDisabled = true
    
    init(presenter: ProfileAcademyScreenPresenter) {
        self.presenter = presenter
        
        if(self.presenter.isEditAcademy){
            self.presenter.onAcademyEdit()
        }
        
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
                
                Text("Academy")
                    .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                    
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                Button(action: {
                    
                    if(self.presenter.isEditAcademy){
                        
                        self.presenter.editAcademyData()
                    } else {
                        self.presenter.addAcademyData()
                        
                    }
                    self.performDismiss()
                    
                }) {
                    if(presenter.isEditAcademy){
                        if !self.isSaveDisabled {
                            Image("ic_confirm")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        } else {
                            Image("ic_confirm")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30).opacity(0.3)
                        }
                        
                    } else {
                        if !self.isSaveDisabled {
                            Image("ic_add_circle")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        } else {
                            Image("ic_add_circle")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30).opacity(0.3)
                        }
                    }
                    
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).disabled(self.isSaveDisabled)
                
            }
            
            VStack {
                
                if presenter.image != nil {
                    presenter.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                        .scaledToFit()
                        .onTapGesture { self.presenter.showImagePicker.toggle() }
                } else {
                    Image("dicoding_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                        .onTapGesture {  self.presenter.showImagePicker.toggle() }
                }
                
                Text("Change Image")
                    .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center).foregroundColor(Color.blue)
                    
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
            }
            
            VStack(alignment: .leading) {
                Text("Title").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                TextField("Academy title ...", text:  $presenter.title).validation(presenter.titleValidation).accentColor(Color.white).foregroundColor(Color.white)
                Divider().background(Color.white)
            }.padding()
            
            VStack(alignment: .leading) {
                Text("Description").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                TextField("Academy description ...", text:  $presenter.desc).validation(presenter.descValidation).accentColor(Color.white).foregroundColor(Color.white)
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

struct ProfileAcademyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let interactor: ProfileAcademyScreenInteractorInputProtocol = ProfileAcademyScreenInteractor()
        
        let presenter: ProfileAcademyScreenPresenter = ProfileAcademyScreenPresenter(interactor: interactor)
        
        return NavigationView {
            ProfileAcademyScreenView(presenter: presenter)
        }
    }
}
