//
//  LeaguesTableViewController.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import UIKit
import Kingfisher
import Foundation

class LeaguesTableViewController: UITableViewController, LeaguesProtocol, FavoriteViewProtocol {
    var sport:String = ""
    var presenter: FavoritePresenter?
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    func renderToView(result: LeaguesResponse) {
        DispatchQueue.main.async {
            self.leagues = result.result
            self.tableView.reloadData()
            LoadingIndicatorUtil.shared.hide()
        }
    }
    
    var leagues : [Leagues] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicatorUtil.shared.show(on: self.view)
        
        presenter = FavoritePresenter(view: self)
        tableView.separatorStyle = .none

        self.title = "Leagues"
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        let fooballLeaguesPresenter = LeaguesPresnter(leagueVC: self)
        fooballLeaguesPresenter.getFootballLeagues(for : sport)
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        let league = leagues[indexPath.row]
 
        let isFavorite = presenter?.isLeagueFavorite(leagueKey: "\(league.league_key)" )
        
        cell.configureLeagueCell(league: league, sportType: sport, isFavorite: isFavorite ?? false)

        cell.onAddToFavorite = { [weak self] isCurrentlyFavorite in
            guard let self = self else { return }
            
            let leagueKey = String(league.league_key)
            
            if isCurrentlyFavorite {
                self.presenter?.removeFromFavorite(league: LocalLeague(
                    leagueKey: "\(league.league_key)", leagueName: league.league_name, leagueLogo: league.league_logo, sportType: sport, isFav: true
                ))
                cell.configureLeagueCell(league: league, sportType: self.sport, isFavorite: false)

                } else {
                let localLeague = LocalLeague(
                    leagueKey: leagueKey,
                    leagueName: league.league_name,
                    leagueLogo: league.league_logo,
                    sportType: self.sport,
                    isFav: true
                )

                self.presenter?.addToFavorite(league: localLeague)
                cell.configureLeagueCell(league: league, sportType: self.sport, isFavorite: true)
            }
        }

        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
      
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsScreen") as? LeagueDetailsCollectionViewController {
            detailsVC.leagueId = String(leagues[indexPath.row].league_key)
            detailsVC.sportType = sport
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        }
    }
    
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
       let verticalPadding: CGFloat = 8
       let horizontalPadding: CGFloat = 16

       let backgroundView = UIView(frame: CGRect(
           x: horizontalPadding,
           y: verticalPadding,
           width: tableView.bounds.width - 2 * horizontalPadding,
           height: cell.contentView.frame.height - 2 * verticalPadding
       ))

       backgroundView.backgroundColor = .clear

    }
    func renderFavoriteUI(leagues: [LocalLeague]) {
         print("legeus in leages\(leagues)")
    }
    
}
