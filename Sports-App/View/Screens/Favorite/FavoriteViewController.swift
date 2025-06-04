//
//  FavoriteViewController.swift
//  Sports-App
//
//  Created by Ayat on 03/06/2025.
//

import UIKit

class FavoriteViewController: UIViewController,FavoriteViewProtocol, UITableViewDelegate, UITableViewDataSource {

    func renderFavoriteUI(leagues: [LocalLeague]) {
      
       leagueList = leagues
        print("fav  list \(leagueList)")
        print("fav  list \(leagues)")
        favoriteTableView.reloadData()
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
        presenter?.fetchFavoriteLeagues()
        favoriteTableView.reloadData()
       let favoriteNib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        favoriteTableView.register(favoriteNib, forCellReuseIdentifier: "cell")

    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
             self.presenter?.removeFromFavorite(league: league)
             self.leagueList.remove(at: indexPath.row)
             self.favoriteTableView.deleteRows(at: [indexPath], with: .fade)
         }

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
}
