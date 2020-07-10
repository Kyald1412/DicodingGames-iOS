//
//  SearchScreenView.swift
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

typealias onSearchScreenGameData = (_ gameId :Int) ->()
typealias onSearchScreenDismiss = () ->()

struct SearchScreenView: View {
    
    @ObservedObject var presenter: SearchScreenPresenter
    var onGameDidTap: onSearchScreenGameData?
    var onDismiss:  onSearchScreenDismiss?
    
    @State var gameName: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Button(action: {
                    self.performDismiss()
                }) {
                    Image("arrow_left_navigation")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                }
                
                Text("Search")
                    .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                    
                    .padding(EdgeInsets(top: 0, leading: -40, bottom: 0, trailing: 0))
                
            }
            
            HStack {
                Button(action: {
                    self.performSearch()
                }) {
                    Image("ic_search")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                }
                
                
                TextField("Find a Game", text: $gameName)
                    .frame(height: 50, alignment: .center)
                    .font(Font.custom("Roboto-Regular",size: 12))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                
                
            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white, lineWidth: 0.3)).padding(EdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 15))
            
            List(presenter.gameSearch) { games in
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .center, spacing: 0) {
                        
                        WebImage(url:
                            imageOptClient.constructURL(
                                imageURL: games.backgroundImage,
                                imageSize: CGSize(width: UIScreen.main.bounds.width, height: 170),
                                crop: true))
                            .resizable()
                            .indicator(.progress)
                            .aspectRatio(2, contentMode: .fit)
                            .transition(.fade)
                    }
                    
                    Text(games.name)
                        .font(Font.custom("Roboto-Regular", size: 14))
                    
                    Spacer()
                        .frame(height: 10)
                    
                }
                .onTapGesture {
                    self.performShowDetailScreen(gameId: games.id)
                }.listRowBackground(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)))
                
                
                
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                .onAppear { UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                    UITableViewCell.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                    
            }
                
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
        
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).background(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
            
        ))
        
    }
    
    func performSearch(){
        self.presenter.onGameSearch(gameName: gameName)
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

struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let interactor: SearchScreenInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchScreenInteractor()
        let searchRemoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager()
        interactor.searchRemoteDataManager = searchRemoteDataManager
        searchRemoteDataManager.remoteRequestHandler = interactor
        
        let presenter: SearchScreenPresenter = SearchScreenPresenter(interactor: interactor)
        
        return NavigationView {
            SearchScreenView(presenter: presenter)
        }
    }
}
