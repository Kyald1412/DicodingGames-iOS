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
    let DETAIL_CONTENT = "detail_content"
    let DETAIL_SNAPSHOT = "detail_snapshot"
    
    var gameDetail: GameDetail?
    var gameDetailScreenshots: GameDetailScreenshots?

    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
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
}

extension DetailScreenView: DetailScreenViewProtocol{
    
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


extension DetailScreenView: UITableViewDelegate, UITableViewDataSource {
    
    func identifierConvert(fromFacility facility: String?) -> String? {
        //Add facility&identifier dependance here.
        let identifiersDic = [DETAIL_HEADER: "DetailHeaderCell",
                              DETAIL_CONTENT: "DetailContentCell",
                              DETAIL_SNAPSHOT: "DetailSnapshotsCell"]
        
        return identifiersDic[facility!]
    }
    
    func tableviewDataModel(withStatus obj: Int?) -> [AnyHashable]? {
        
        var model = [AnyHashable]()
        model.append(DETAIL_HEADER)
        model.append(DETAIL_CONTENT)
        model.append(DETAIL_SNAPSHOT)
        
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
                cell.lblRating.text = "\(gameData.ratingsCount ?? 0)"
                cell.imgView.sd_imageIndicator = SDWebImageProgressIndicator.default;
                cell.imgView.sd_setImage(with: URL(string: gameData.backgroundImage ?? "_")!)
                cell.imgEsrb?.image = UIImage(named: gameData.esrbImageName)
                
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if (facility == DETAIL_CONTENT){
            let cell: DetailContentCell = (tableView.dequeueReusableCell(withIdentifier: identifierConvert(fromFacility: facility)!) as? DetailContentCell)!
            
            if let gameData = self.gameDetail {
                
                cell.lblReleaseDate.text = gameData.released
                cell.lblCategory.text = gameData.genresStringBuilder
                cell.lblPlatform.text = gameData.platformStringBuilder
                cell.lblDescription.text = gameData.descriptionRaw
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
        
        return UITableView.automaticDimension
        
    }
    
}
