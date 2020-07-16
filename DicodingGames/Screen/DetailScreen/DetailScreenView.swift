//
//  DetailScreenView.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import PKHUD
import SDWebImage

class DetailScreenView: UIViewController {
    var presenter: DetailScreenPresenterProtocol?
    
    let DETAIL_HEADER = "detail_header"
    let DETAIL_CONTENT_HEAD = "detail_head_content"
    let DETAIL_CONTENT = "detail_content"
    let DETAIL_SNAPSHOT = "detail_snapshot"
    let DETAIL_SUGGESTED = "detail_suggested"
    
    var gameDetail: GameDetail?
    var gameSuggested: [Results] = []
    var gameDetailScreenshots: GameDetailScreenshots?
    
    private var isMyFavorite: Bool = false
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var icFavorite: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.presenter?.interactor?.retrieveGameDetailData(gameId: self.presenter?.gameId ?? 0)
        self.presenter?.interactor?.retrieveGameDetailScreenshots(gameId: self.presenter?.gameId ?? 0)
        
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        
        if let gameData = self.gameDetail {
            
            if(self.isMyFavorite){
                self.presenter?.interactor?.deleteGameFavoriteData(gameId: gameData.id ?? 0)
                self.checkMyFavorite(with: false)
            } else {
                self.presenter?.interactor?.saveFavoriteGame(id: gameData.id ?? 0, title: gameData.name ?? "", desc: gameData.descriptionRaw?.withoutHtmlTags ?? "", rating: "\(gameData.ratingBuilder)",release_date: gameData.released ?? "", imageUrl: gameData.backgroundImage ?? "")
                self.checkMyFavorite(with: true)
            }
            
        }
    }
    
}

extension DetailScreenView: DetailScreenViewProtocol{
    func showGameSuggested(with gameDetail: GameModel) {
        self.gameSuggested = gameDetail.results ?? []
        
        self.tableView.reloadData()
//        self.tableView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .automatic)
        self.refreshControl.endRefreshing()
    }
    
    func checkMyFavorite(with isMyFavorite: Bool) {
        self.isMyFavorite = isMyFavorite
        
        if(isMyFavorite){
            self.icFavorite.image = UIImage(named: "heart_white_fill")
        } else {
            self.icFavorite.image = UIImage(named: "heart_white")
        }
        
    }
    
    func showGameScreenshots(with gameScreenshots: GameDetailScreenshots) {
        self.gameDetailScreenshots = gameScreenshots
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func showGameDetail(with gameDetail: GameDetail) {
        self.gameDetail = gameDetail
        self.tableView.reloadData()
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


extension DetailScreenView: UITableViewDelegate, UITableViewDataSource, DetailSuggestedDelegate {
    func collectionView(collectionviewcell: DetailSuggestedContentCell?, index: Int, didTappedInTableViewCell: DetailSuggestedCell) {
        
        self.presenter?.showDetailScreen(gameId: self.gameSuggested[index].id)
        
    }
    
    
    func identifierConvert(fromFacility facility: String?) -> String? {
        //Add facility&identifier dependance here.
        let identifiersDic = [DETAIL_HEADER: "DetailHeaderCell",
                              DETAIL_CONTENT_HEAD: "DetailContentHeadCell",
                              DETAIL_CONTENT: "DetailContentCell",
                              DETAIL_SNAPSHOT: "DetailSnapshotsCell",
                              DETAIL_SUGGESTED: "DetailSuggestedCell"]
        
        return identifiersDic[facility!]
    }
    
    func tableviewDataModel(withStatus obj: Int?) -> [AnyHashable]? {
        
        var model = [AnyHashable]()
        model.append(DETAIL_HEADER)
        model.append(DETAIL_CONTENT_HEAD)
        model.append(DETAIL_SNAPSHOT)
        model.append(DETAIL_CONTENT)
        model.append(DETAIL_SUGGESTED)
        
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
        
        if (facility == DETAIL_HEADER){
            let cell: DetailHeaderCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? DetailHeaderCell)!
            
            if let gameData = self.gameDetail {
                
                cell.lblPublisher.text = gameData.publishersStringBuilder
                cell.lblTitle.text = gameData.name
                cell.lblRating.text = "\(gameData.ratingBuilder)"
                cell.imgView.sd_imageIndicator = SDWebImageProgressIndicator.default;
                cell.imgView.sd_setImage(with: URL(string: gameData.backgroundImage ?? "_")!)
                cell.imgEsrb?.image = UIImage(named: gameData.esrbImageName)
                
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == DETAIL_CONTENT_HEAD){
            let cell: DetailContentHeadCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? DetailContentHeadCell)!
            
            if let gameData = self.gameDetail {
                
                cell.lblReleaseDate.text = gameData.released
                cell.lblCategory.text = gameData.genresStringBuilder
                cell.lblPlatform.text = gameData.platformStringBuilder
                
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == DETAIL_CONTENT){
            let cell: DetailContentCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? DetailContentCell)!
            
            if let gameData = self.gameDetail {
                
                cell.lblDescription.text = gameData.descriptionRaw?.withoutHtmlTags
                cell.lblDescription.addInterlineSpacing(spacingValue: 2)
                
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == DETAIL_SNAPSHOT){
            let cell: DetailSnapshotsCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? DetailSnapshotsCell)!
            
            cell.subCategoryLabel.text = "Snapshots"
            
            if let screenshotLists = self.gameDetailScreenshots {
                cell.updateCellWith(row: screenshotLists)
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
               
        if (facility == DETAIL_SUGGESTED){
            let cell: DetailSuggestedCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? DetailSuggestedCell)!
            
            cell.subCategoryLabel.text = "You might also like"
            
            cell.seeAllSuggestedView.addTapGesture { (tap) in
                self.presenter?.showSuggestedGameList(gameId: self.presenter?.gameId ?? 0)
            }
            
            cell.updateCellWith(row: self.gameSuggested)
            
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
        
        if (facility == DETAIL_HEADER) {
            return 400
        }
        
        if (facility == DETAIL_SNAPSHOT) {
            return 200
        }
        
        if (facility == DETAIL_SUGGESTED) {
            return 220
        }
        
        return UITableView.automaticDimension
        
    }
    
}
