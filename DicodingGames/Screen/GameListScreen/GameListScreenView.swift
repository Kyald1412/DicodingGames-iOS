//
//  GameListScreenView.swift
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
import Combine

typealias onGameListScreenGameData = (_ gameId :Int) ->()
typealias onGameListScreenDismiss = () ->()

struct GameListScreenView: View {
    @ObservedObject var presenter: GameListScreenPresenter
    
    var onGameDidTap: onGameListScreenGameData?
    var onDismiss:  onGameListScreenDismiss?
    
    
    init(presenter: GameListScreenPresenter) {
        self.presenter = presenter
        
        self.presenter.onGameList(query: self.presenter.query)
    }
    
    var body: some View {
        RepositoriesList(
            title: self.presenter.title,
            repos: self.presenter.gameList,
            isLoading: self.presenter.isLoading,
            onScrolledAtBottom: self.presenter.onNextPage,
            onDismiss: self.onDismiss!,
            onGameDidTap: self.onGameDidTap!
        ).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .background(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)).edgesIgnoringSafeArea(.top))
            .onAppear(perform: self.presenter.onNextPage)
    }
}

struct RepositoriesList: View {
    let title: String
    let repos: [Results]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    let onDismiss: () ->()
    let onGameDidTap: (_ gameId :Int) ->()
    
    
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
                
                Text(title)
                    .font(Font.custom("Roboto-Regular", size: 14)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .center)
                    
                    .padding(EdgeInsets(top: 0, leading: -40, bottom: 0, trailing: 0))
                
            }
            
            
            List{

                ForEach(repos) { repo in
                    GameRow(games: repo).onAppear {
                        if self.repos.last == repo {
                            self.onScrolledAtBottom()
                        }
                    }
                    .onTapGesture {
                        self.performShowDetailScreen(gameId: repo.id)
                    }.listRowBackground(Color.init(UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                    .onAppear { UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                        UITableViewCell.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)

                }

                .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                if isLoading {
                    loadingIndicator
                } else {
                    VStack(alignment: .center, spacing: 10) {
                        Divider()
                        Text("--- You've browsed all the games ---")
                            .font(Font.custom("Roboto-Regular", size: 14))
                    }

                }
            }    .onAppear { UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
                UITableViewCell.appearance().backgroundColor = UIColor(red: 0.03, green: 0.03, blue: 0.07, alpha: 1.00)
            }
        }
        
        
    }
    
    private var loadingIndicator: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("Fetch more ...")
                .font(Font.custom("Roboto-Regular", size: 14))
            
            Spinner(style: .medium)
                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
        }
    }
    
    func performShowDetailScreen(gameId: Int){
        
        onGameDidTap(gameId)
    }
    func performDismiss(){
        onDismiss()
    }
}

struct GameRow: View {
    let games: Results
    
    var body: some View {
        
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
                    .overlay(GameListTextOverlay(games: games))
            }

            Text(games.name)
                .font(Font.custom("Roboto-Regular", size: 14))

            Spacer()
                .frame(height: 10)


        }
    }
}

struct GameListTextOverlay: View {
    var games: Results

    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            HStack(alignment: .bottom, spacing: 5) {
                HStack(alignment: .center, spacing: 5) {
                    Image("ic_star")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                    Text("\(games.ratingBuilder)")
                        .font(Font.custom("Roboto-Regular", size: 14))
                }.padding(5).background(Color.init(UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
                    
                ))
                Spacer()
                HStack(alignment: .center, spacing: 5) {
                    Text("\(games.released ?? "-")")
                        .font(Font.custom("Roboto-Regular", size: 14))
                }.padding(5).background(Color.init(UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
                ))
                
            }.padding(10)
        }
        
    }
}


struct GameListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let interactor: GameListScreenInteractorInputProtocol & GameListRemoteDataManagerOutputProtocol = GameListScreenInteractor()
        let gameListRemoteDataManager: GameListRemoteDataManagerInputProtocol = GameListRemoteDataManager()
        interactor.gameListRemoteDataManager = gameListRemoteDataManager
        gameListRemoteDataManager.remoteRequestHandler = interactor
        
        let presenter: GameListScreenPresenter = GameListScreenPresenter(interactor: interactor)
        
        return NavigationView {
            GameListScreenView(presenter: presenter)
        }
    }
}




struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
