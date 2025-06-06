//
//  FavoriteViewController.swift
//  Sports-App
//
//  Created by Ayat on 03/06/2025.
//

import UIKit

class FavoriteViewController: UIViewController,FavoriteViewProtocol, UITableViewDelegate, UITableViewDataSource {
  
    

    func renderFavoriteUI(leagues: [LocalLeague]) {
        DispatchQueue.main.async {
            self.leagueList = leagues
            self.favoriteTableView.reloadData()
        }
      
    }
    var presenter: FavoritePresenterProtocol?

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var leagueList : [LocalLeague] = []
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchFavoriteLeagues()
        favoriteTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        presenter = FavoritePresenter(view: self)
        
        DispatchQueue.main.async {
            self.presenter?.fetchFavoriteLeagues()
            self.favoriteTableView.reloadData()

        }

        NetworkReachabilityManager.shared.startMonitoring()
        
       let favoriteNib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        favoriteTableView.register(favoriteNib, forCellReuseIdentifier: "cell")

    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell

        let league = leagueList[indexPath.row]
        cell.configureFavoriteLeagueCell(league: league)

        cell.onAddToFavorite = { [weak self] isCurrentlyFavorite in
            guard let self = self else { return }
            let league = self.leagueList[indexPath.row]
            AlertUtils.showConfirmationAlert(
                on: self,
                title: "Confirm Deletion",
                message: "Are you sure you want to remove this league from favorites?",
                confirmHandler: { [weak self] in
                guard let self = self else { return }

                self.presenter?.removeFromFavorite(league: league)
                self.leagueList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
    
        }

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
            
            if NetworkReachabilityManager.shared.isNetworkAvailable {
                if let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsScreen") as? LeagueDetailsCollectionViewController {
                    let selectedLeague = leagueList[indexPath.row]
                    detailsVC.leagueId = selectedLeague.leagueKey ?? ""
                    detailsVC.sportType = selectedLeague.sportType ?? " "
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
            } else {
                AlertUtils.showInfoAlert(on: self,
                                            title: "No Internet Connection",
                                            message: "Please check your network connection and try again.")
            }
        }
        
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        let horizontalPadding: CGFloat = 16
        let frame = cell.frame
        cell.frame = CGRect(x: frame.origin.x + horizontalPadding,
                            y: frame.origin.y + verticalPadding,
                            width: frame.size.width - 2 * horizontalPadding,
                            height: frame.size.height - verticalPadding)
        cell.backgroundColor = .clear
    }

     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let league = leagueList[indexPath.row]

            AlertUtils.showConfirmationAlert(on: self,
                                             title: "Confirm Deletion",
                                             message: "Are you sure you want to remove this league from favorites?",
                                             confirmHandler: { [weak self] in
                guard let self = self else { return }

                self.presenter?.removeFromFavorite(league: league)
                self.leagueList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
        }
    }
    
}
