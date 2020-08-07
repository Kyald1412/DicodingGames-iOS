//
//  HomeScreenPresenter.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

class HomeScreenPresenter: HomeScreenPresenterProtocol {

    weak var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorInputProtocol?
    var wireFrame: HomeScreenWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        
        interactor?.retrieveGamesData(size: 5)
        interactor?.retrievePopularNowGamesData()
        interactor?.retrieveUpcomingGamesData()
        interactor?.retrieveNewReleaseGamesData()
        interactor?.retrieveLocalFavoriteCount()
    }
    
    func showFavoriteScreenView() {
        wireFrame?.presentFavoriteScreen(from: view!)
    }
    func showProfileView() {
        wireFrame?.presentProfileScreen(from: view!)
    }
    func showSearchView() {
        wireFrame?.presentSearchScreen(from: view!)
    }
    func showDetailScreenView(_ games: Int) {
        wireFrame?.presentDetailScreen(from: view!, games: games)
    }
    func showGameListScreen() {
        wireFrame?.presentGameListScreen(from: view!)
    }

}

extension HomeScreenPresenter: HomeScreenInteractorOutputProtocol {
    func didRetrieveFavoriteGamesCount(_ favorite: Bool) {
        view?.showFavoriteGamesCount(with: favorite)
    }
    
    func didRetrieveNewReleaseGamesData(_ games: GameModel) {
        view?.hideLoading()
        view?.showNewReleasedGames(with: games)
    }
    
    func didRetrievePopularNowGames(_ games: GameModel) {
        view?.hideLoading()
        view?.showPopularNowGames(with: games)

    }
    
    func didRetrieveUpcomingGames(_ games: GameModel) {
        view?.hideLoading()
        view?.showUpcomingGames(with: games)
    }
    
    func didRetrieveGames(_ games: GameModel) {
        view?.hideLoading()
        view?.showBannerGames(with: games)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}
