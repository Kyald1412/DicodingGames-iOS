//
//  HomeScreenView.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import PKHUD
import ImageSlideshow
import SDWebImage
import Closures

class HomeScreenView: UIViewController {
    
    var presenter: HomeScreenPresenterProtocol?
    
    let HOME_BANNER = "home_banner"
    let HOME_TOP_GAME_POPULAR = "home_top_game_popular"
    let HOME_UPCOMING_GAME = "home_upcoming_game"
    
    private var BANNER_PHOTO_LIST = [SDWebImageSource]()
    
    private var bannerGameList: [Results]? = []
    private var upcomingGameList: [Results]? = []
    private var popularNowGameList: [Results]? = []
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeScreenWireFrame.createHomeScreenModule(homeScreenRef: self)
        presenter?.viewDidLoad()
        
        tableViewSetup()
    }
    
    func tableViewSetup(){
        
        self.tableView.contentInset.bottom = 50
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.presenter?.interactor?.retrieveGamesData(size: 5)
        self.presenter?.interactor?.retrieveUpcomingGamesData()
        self.presenter?.interactor?.retrievePopularNowGamesData()
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        self.presenter?.showSearchView()
    }
    
    @IBAction func onProfileButton(_ sender: Any) {
        self.presenter?.showProfileView()
    }
    
}

extension HomeScreenView: HomeScreenViewProtocol {
    func showBannerGames(with games: GameModel) {
        guard let results = games.results  else { return }
        
        BANNER_PHOTO_LIST.removeAll()
        
        for data in results {
            BANNER_PHOTO_LIST.append(SDWebImageSource(url: URL(string: data.backgroundImage)!))
        }
        
        self.bannerGameList = results
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.refreshControl.endRefreshing()

    }
    
    func showPopularNowGames(with games: GameModel) {
        guard let results = games.results  else { return }
        self.popularNowGameList = results
        self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
        self.refreshControl.endRefreshing()

    }
    
    func showUpcomingGames(with games: GameModel) {
        guard let results = games.results  else { return }
        self.upcomingGameList = results
        self.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
        self.refreshControl.endRefreshing()

    }
    
    func showError() {
        HUD.hide()
        self.refreshControl.endRefreshing()
    }
    
    func showLoading() {
        //        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
        self.refreshControl.endRefreshing()
    }
    
}

extension HomeScreenView: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        
        print("PAGE CHANGED \(page)")
        if let gameList = self.bannerGameList {
            let cell = tableView.cellForRow(at: IndexPath.init(item: 0, section: 0)) as? HomeBannerCell
            cell?.lblTitle.text = gameList[page].name
            cell?.indicator.currentPage = page
        }
    }
}

extension HomeScreenView: UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.layoutIfNeeded()
    }
    
    func identifierConvert(fromFacility facility: String?) -> String? {
        //Add facility&identifier dependance here.
        let identifiersDic = [HOME_BANNER: "HomeBannerCell",
                              HOME_TOP_GAME_POPULAR: "HomeGameCell",
                              HOME_UPCOMING_GAME: "HomeGameCell"]
        
        return identifiersDic[facility!]
    }
    
    func tableviewDataModel(withStatus obj: Int?) -> [AnyHashable]? {
        
        var model = [AnyHashable]()
        model.append(HOME_BANNER)
        model.append(HOME_TOP_GAME_POPULAR)
        model.append(HOME_UPCOMING_GAME)
        
        return model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewDataModel(withStatus: 0)!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = tableviewDataModel(withStatus: 0)
        let facility = model![indexPath.row] as? String
        
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!)
        
        cell?.selectionStyle = .none
        
        if (facility == HOME_BANNER){
            let cell: HomeBannerCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeBannerCell)!
            
            cell.viewSlider.pageIndicator = nil
            
            cell.viewSlider.delegate = self
            
            cell.viewSlider.contentScaleMode = .scaleAspectFill
            
            cell.viewSlider.setImageInputs(BANNER_PHOTO_LIST)
            
            cell.indicator.numberOfPages = BANNER_PHOTO_LIST.count
            cell.indicator.currentPageIndicatorTintColor = UIColor(red: 0.71, green: 0.09, blue: 0.09, alpha: 1.00)
            
            
            cell.viewSlider.activityIndicator = DefaultActivityIndicator()
            
            if self.bannerGameList?.count ?? 0 > 0 {
                cell.lblTitle.text = self.bannerGameList?[0].name
            }
            
            cell.indicator.bringSubviewToFront(cell.contentView)
            cell.viewSlider.pageIndicatorPosition = PageIndicatorPosition(horizontal: .left(padding: 20), vertical: .customBottom(padding: 8))
            
            cell.viewSlider.addTapGesture { (tap) in
                
                print("asdasd \(cell.viewSlider.currentPage)")
                print("asdasd \(cell.viewSlider.currentPage)")

                guard let results = self.bannerGameList else { return }
                
                if(results.count > 0){
                    self.presenter?.showDetailScreenView(results[cell.viewSlider.currentPage].id)
                }
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == HOME_TOP_GAME_POPULAR){
            let cell: HomeGameCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeGameCell)!
            
            cell.subCategoryLabel.text = "Popular"
            
            if let gameList = self.popularNowGameList {
                cell.updateCellWith(row: gameList)
            }
            
            cell.cellIdentifier = HOME_TOP_GAME_POPULAR
            
            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == HOME_UPCOMING_GAME){
            let cell: HomeGameCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeGameCell)!
            
            cell.subCategoryLabel.text = "Upcoming Games"
            
            if let gameList = self.upcomingGameList {
                cell.updateCellWith(row: gameList)
            }
            
            cell.cellIdentifier = HOME_UPCOMING_GAME
            
            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        return cell!
        
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let model = tableviewDataModel(withStatus: 0)
        let facility = model![indexPath.row] as? String
        
        if (facility == HOME_BANNER) {
            return 300
        }
        
        return 300
        
    }
    
}


extension HomeScreenView: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: HomeGameContentCell?, index: Int, didTappedInTableViewCell: HomeGameCell) {
        
        if didTappedInTableViewCell.cellIdentifier == HOME_TOP_GAME_POPULAR {
            if let gameData = self.popularNowGameList?[index] {
                self.presenter?.showDetailScreenView(gameData.id)
            }
            
        } else {
            if let gameData = self.upcomingGameList?[index] {
                self.presenter?.showDetailScreenView(gameData.id)
            }
        }
        
        
    }
}
