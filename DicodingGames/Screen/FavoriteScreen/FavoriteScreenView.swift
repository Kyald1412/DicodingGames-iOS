//
//  FavoriteScreenView.swift
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

typealias onFavoriteScreenDismiss = () ->()
typealias onFavoriteScreenGameData = (_ gameId :Int) ->()

struct FavoriteScreenView: View {
    
    @ObservedObject var presenter: FavoriteScreenPresenter
    var onGameDidTap: onFavoriteScreenGameData?
    var onDismiss: onFavoriteScreenDismiss?
    
    @State var gameName: String = ""
    
    init(presenter: FavoriteScreenPresenter) {
        self.presenter = presenter
        
        self.presenter.onGameFavorite()
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
                
                Text("Favorite")
                    .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                    
                    .padding(EdgeInsets(top: 0, leading: -40, bottom: 0, trailing: 0))
                
            }
            
            List(presenter.gameFavorites){ games in
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .center, spacing: 0) {
                        
                        WebImage(url:
                            imageOptClient.constructURL(
                                imageURL: games.game_img_url,
                                imageSize: CGSize(width: UIScreen.main.bounds.width, height: 170),
                                crop: true))
                            .resizable()
                            .indicator(.progress)
                            .aspectRatio(2, contentMode: .fit)
                            .transition(.fade)
                    }
                    
                    Text(games.game_title)
                        .font(Font.custom("Roboto-Regular", size: 14))
                    
                    Spacer()
                        .frame(height: 10)
                    
                    
                }.onTapGesture {
                    self.performShowDetailScreen(gameId: Int(games.game_id))
                    
                }.listRowBackground(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)))
                 
                
                .contextMenu {
                               Button(action: {
                                   // change country setting
                                self.presenter.onGameDelete(id: Int(games.game_id))
                               }) {
                                   Text("Delete this item?")
                                   Image(systemName: "globe")
                               }

                           }
                
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                .onAppear { UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                    UITableViewCell.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                    
            }
                
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
            
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).background(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
            
        ))
        
    }
    
    func performShowDetailScreen(gameId: Int){
           guard let onGameTap = onGameDidTap else {return}
           onGameTap(gameId)
       }
    func performDismiss(){
        guard let dismiss = onDismiss else {return}
        dismiss()
    }
}

struct FavoriteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let interactor: FavoriteScreenInteractorInputProtocol = FavoriteScreenInteractor()
        let favoriteLocalDataManager: FavoriteLocalDataManagerInputProtocol = FavoriteLocalDataManager()
        interactor.favoriteLocalDataManager = favoriteLocalDataManager
        
        let presenter: FavoriteScreenPresenter = FavoriteScreenPresenter(interactor: interactor)
        
        return NavigationView {
            FavoriteScreenView(presenter: presenter)
        }
    }
}
