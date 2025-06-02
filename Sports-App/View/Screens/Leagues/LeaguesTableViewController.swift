//
//  LeaguesTableViewController.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import UIKit
import Kingfisher
class LeaguesTableViewController: UITableViewController, LeaguesProtocol {
    
    var sport:String = ""
    
    func renderToView(result: LeaguesResponse) {
        DispatchQueue.main.async {
            self.leagues = result.result
            self.tableView.reloadData()
        }
    }
    
    var leagues : [Leagues] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let leagues = leagues[indexPath.row]
        cell.leagueName.text = leagues.league_name
        if sport == "Cricket" {
               cell.leagueCountry.text = leagues.league_year
           } else {
               cell.leagueCountry.text = leagues.country_name
           }

        if let leagueUrl = URL(string: leagues.league_logo ?? " "){
            cell.leagueImage.kf.setImage(with: leagueUrl, placeholder: UIImage(systemName: "league"))
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

        // Create background view with padding
        let backgroundView = UIView(frame: CGRect(
            x: horizontalPadding,
            y: verticalPadding,
            width: tableView.bounds.width - 2 * horizontalPadding,
            height: cell.contentView.frame.height - 2 * verticalPadding
        ))

        backgroundView.backgroundColor = .clear

        // Apply shadow and corner styling here if needed
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor(named: "DarkPurple")?.cgColor ?? UIColor.white.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.backgroundView = backgroundView
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false

    }


    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200 // space between cells
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        
        spacer.backgroundColor = .clear // or custom color if needed
        return spacer
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
