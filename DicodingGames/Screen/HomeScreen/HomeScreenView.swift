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
    
    let homeBanner = "homeBanner"
    let homeTopGamePopular = "homeTopGamePopular"
    let homeUpcomingGame = "homeUpcomingGame"
    let homeNewReleaseHeader = "homeNewReleases_header"
    let homeNewRelease = "homeNewReleases"

    private var bannerPhotoList = [SDWebImageSource]()
    
    private var bannerGameList: [Results]? = []
    private var upcomingGameList: [Results]? = []
    private var popularNowGameList: [Results]? = []
    private var newReleaseGameList: [Results]? = []
    private var isFavorite: Bool = false

    @IBOutlet weak var tableView: UITableView!
    
    var cachedPopularNowPosition = Dictionary<IndexPath, CGPoint>()
    var cachedUpcomingPosition = Dictionary<IndexPath, CGPoint>()
    var cachedBannerPosition = 0
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeScreenWireFrame.createHomeScreenModule(homeScreenRef: self)
        presenter?.viewDidLoad()
        
        tableViewSetup()
    }
    
    func tableViewSetup() {
        
        self.tableView.contentInset.bottom = 50
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.interactor?.retrieveLocalFavoriteCount()
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.presenter?.interactor?.retrieveGamesData(size: 5)
        self.presenter?.interactor?.retrieveUpcomingGamesData()
        self.presenter?.interactor?.retrievePopularNowGamesData()
        self.presenter?.interactor?.retrieveLocalFavoriteCount()
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        self.presenter?.showSearchView()
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        self.presenter?.showFavoriteScreenView()
    }
    
    @IBAction func onProfileButton(_ sender: Any) {
        self.presenter?.showProfileView()
    }
    
}

extension HomeScreenView: HomeScreenViewProtocol {
    
    func showFavoriteGamesCount(with favorite: Bool) {
        self.isFavorite = favorite
        self.tableView.reloadSections(IndexSet.init(integer: 0), with: .none)
    }
    
    func showNewReleasedGames(with games: GameModel) {
        guard let results = games.results  else { return }
        self.newReleaseGameList = results
        self.tableView.reloadSections(IndexSet.init(integer: 4), with: .automatic)
        self.refreshControl.endRefreshing()

    }
    
    func showBannerGames(with games: GameModel) {
        guard let results = games.results  else { return }
        
        bannerPhotoList.removeAll()
        
        for data in results {
            bannerPhotoList.append(SDWebImageSource(url: URL(string: data.backgroundImage)!))
        }
        
        self.bannerGameList = results
        self.tableView.reloadSections(IndexSet.init(integer: 0), with: .automatic)
        self.refreshControl.endRefreshing()

    }
    
    func showPopularNowGames(with games: GameModel) {
        guard let results = games.results  else { return }
        self.popularNowGameList = results
        self.tableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        self.refreshControl.endRefreshing()

    }
    
    func showUpcomingGames(with games: GameModel) {
        guard let results = games.results  else { return }
        self.upcomingGameList = results
        self.tableView.reloadSections(IndexSet.init(integer: 2), with: .automatic)
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
        
        if let gameList = self.bannerGameList {
            let cell = tableView.cellForRow(at: IndexPath.init(item: 0, section: 0)) as? HomeBannerCell
            cell?.lblTitle.text = gameList[page].name
            cell?.indicator.currentPage = page
            self.cachedBannerPosition = page
        }
    }
}

extension HomeScreenView: UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HomeGameCell {
                        
            if(cell.cellIdentifier == homeUpcomingGame) {
                cachedUpcomingPosition[indexPath] = cell.collectionView.contentOffset
            }
            if(cell.cellIdentifier == homeTopGamePopular) {
                cachedPopularNowPosition[indexPath] = cell.collectionView.contentOffset
            }
        }
    }
    
    func identifierConvert(fromFacility facility: String?) -> String? {
        //Add facility&identifier dependance here.
        let identifiersDic = [homeBanner: "HomeBannerCell",
                              homeTopGamePopular: "HomeGameCell",
                              homeUpcomingGame: "HomeGameCell",
                              homeNewReleaseHeader: "HomeNewReleaseHeadCell",
                              homeNewRelease: "HomeNewReleaseCell"]
        
        return identifiersDic[facility!]
    }
    
    func tableviewDataModel(with section: Int?) -> [AnyHashable]? {
        
        var model = [AnyHashable]()
        
        if(section == 0) {
            model.append(homeBanner)
        }
        if(section == 1) {
            model.append(homeTopGamePopular)
        }
        if(section == 2) {
            model.append(homeUpcomingGame)
        }
        if(section == 3) {
            model.append(homeNewReleaseHeader)
        }
        if(section == 4) {
            if let newReleaseGameData = self.newReleaseGameList {
                for _ in newReleaseGameData {
                    model.append(homeNewRelease)
                }
            }
        }
        
        return model
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableviewDataModel(with: section)!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = tableviewDataModel(with: indexPath.section)
        let facility = model![indexPath.row] as? String
        
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!)
        
        cell?.selectionStyle = .none
        
        if (facility == homeBanner) {
            let cell: HomeBannerCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeBannerCell)!
            
            cell.viewSlider.pageIndicator = nil
            
            cell.viewSlider.delegate = self
            
            cell.viewSlider.contentScaleMode = .scaleAspectFill
            
            cell.viewSlider.setImageInputs(bannerPhotoList)
            
            cell.indicator.numberOfPages = bannerPhotoList.count
            cell.indicator.currentPageIndicatorTintColor = UIColor(red: 0.71, green: 0.09, blue: 0.09, alpha: 1.00)
            
            cell.viewSlider.activityIndicator = DefaultActivityIndicator()
            
            if self.bannerGameList?.count ?? 0 > 0 {
                cell.lblTitle.text = self.bannerGameList?[self.cachedBannerPosition].name
                cell.indicator.currentPage = self.cachedBannerPosition
                cell.viewSlider.setCurrentPage(self.cachedBannerPosition, animated: true)
            }
            
            if self.isFavorite {
                cell.icFavorite.setImage(UIImage.init(named: "heart_white_fill"), for: .normal)
            } else {
                cell.icFavorite.setImage(UIImage.init(named: "heart_white"), for: .normal)
            }
            
            cell.indicator.bringSubviewToFront(cell.contentView)
            cell.viewSlider.pageIndicatorPosition = PageIndicatorPosition(horizontal: .left(padding: 20), vertical: .customBottom(padding: 8))
            
            cell.viewSlider.addTapGesture { _ in
    
                guard let results = self.bannerGameList else { return }
                
                if(results.count > 0) {
                    self.presenter?.showDetailScreenView(results[cell.viewSlider.currentPage].id)
                }
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == homeTopGamePopular) {
            let cell: HomeGameCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeGameCell)!
            
            cell.subCategoryLabel.text = "Popular"
            
            if let gameList = self.popularNowGameList {
                cell.updateCellWith(row: gameList)
            }
            
            cell.cellIdentifier = homeTopGamePopular
            
            cell.collectionView.contentOffset = cachedPopularNowPosition[indexPath] ?? .zero

            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == homeUpcomingGame) {
            let cell: HomeGameCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeGameCell)!
            
            cell.subCategoryLabel.text = "Upcoming Games"
            
            if let gameList = self.upcomingGameList {
                cell.updateCellWith(row: gameList)
            }
            
            cell.cellIdentifier = homeUpcomingGame
            
            cell.collectionView.contentOffset = cachedUpcomingPosition[indexPath] ?? .zero

            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == homeNewReleaseHeader) {
            let cell: HomeNewReleaseHeadCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeNewReleaseHeadCell)!
            
            cell.lblTitle.text = "New Releases"
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == homeNewRelease) {
            let cell: HomeNewReleaseCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? HomeNewReleaseCell)!
            
            if self.newReleaseGameList?.count ?? 0 > 0 {
                cell.lblTitle.text = self.newReleaseGameList?[indexPath.row].name
                cell.lblGenre.text = self.newReleaseGameList?[indexPath.row].genresStringBuilder
                
                let url = URL(string: self.newReleaseGameList?[indexPath.row].backgroundImage ?? "_")
                
                cell.img.sd_imageIndicator = SDWebImageProgressIndicator.default
                cell.img.sd_setImage(with: url) { (image, error, _, _) in
                    if (error != nil) {
                           cell.img.image = UIImage(named: "dicoding_logo")
                    } else {
                           cell.img.image = image
                    }
                }
                
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        return cell!
        
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = tableviewDataModel(with: indexPath.section)
        let facility = model![indexPath.row] as? String
        
        if (facility == homeBanner) { return 300 }
        
        if (facility == homeNewReleaseHeader) { return 60 }
        
        if (facility == homeNewRelease) {
            return UITableView.automaticDimension
        }
        
        return 300
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = tableviewDataModel(with: indexPath.section)
        let facility = model![indexPath.row] as? String
        
        if (facility == homeNewReleaseHeader) {
            self.presenter?.showGameListScreen()
        }
        if (facility == homeNewRelease) {
            if(self.newReleaseGameList?.count ?? 0 > 0) {
                self.presenter?.showDetailScreenView(self.newReleaseGameList?[indexPath.row].id ?? 0)
            }
            
        }
    }
    
}

extension HomeScreenView: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: HomeGameContentCell?, index: Int, didTappedInTableViewCell: HomeGameCell) {
        
        if didTappedInTableViewCell.cellIdentifier == homeTopGamePopular {
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
