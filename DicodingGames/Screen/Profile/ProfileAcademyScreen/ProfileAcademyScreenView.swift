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

    @State var title: String = ""
    @State var description: String = ""

    init(presenter: ProfileAcademyScreenPresenter) {
        self.presenter = presenter
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
                    self.performDismiss()
                }) {
                    Image("ic_confirm")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            
            VStack {
                
               Image("placeholder_gta")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
                .clipped()
                .cornerRadius(8)
//                .clipShape(Circle())
//                .border(Color.blue, width:1)

                Text("Change Image")
                    .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center).foregroundColor(Color.blue)
                    
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
            }
            
            VStack(alignment: .leading) {
                Text("Title").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                TextField("Academy title ...", text:  $title).accentColor(Color.white).foregroundColor(Color.white)
                Divider().background(Color.white)
            }.padding()
            
            VStack(alignment: .leading) {
                Text("Description").font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .leading).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)).foregroundColor(Color.gray)
                TextField("Academy description ...", text:  $description).accentColor(Color.white).foregroundColor(Color.white)
                Divider().background(Color.white)
            }.padding()
            
            Spacer()

            
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).background(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                
            ))
        

    }
    
    func performDismiss(){
          guard let dismiss = onDismiss else {return}
          dismiss()
      }
}

struct ProfileAcademyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let interactor: ProfileAcademyScreenInteractorInputProtocol = ProfileAcademyScreenInteractor()
        //        let profileAcademyLocalDataManager: ProfileAcademyLocalDataManagerInputProtocol = ProfileAcademyLocalDataManager()
        //        interactor.profileAcademyLocalDataManager = profileAcademyLocalDataManager
        
        let presenter: ProfileAcademyScreenPresenter = ProfileAcademyScreenPresenter(interactor: interactor)
        
        return NavigationView {
            ProfileAcademyScreenView(presenter: presenter)
        }
    }
}
