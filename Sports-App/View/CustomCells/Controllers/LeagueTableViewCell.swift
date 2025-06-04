//
//  LeagueTableViewCell.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var favIcon: UIButton!
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var leagueCountry: UILabel!
    var onAddToFavorite: ((_ isCurrentlyFavorite: Bool) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "DarkPurple")?.cgColor ?? UIColor.white.cgColor
        contentView.layer.masksToBounds = true
        
        backgroundView = backgroundView
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
       }
       
       func configureLeagueCell(league: Leagues, sportType: String, isFavorite: Bool) {
           leagueName.text = league.league_name
           leagueCountry.text = (sportType == "Cricket") ? league.league_year : league.country_name

           if let leagueUrl = URL(string: league.league_logo ?? " ") {
               leagueImage.kf.setImage(with: leagueUrl, placeholder: UIImage(systemName: "photo"))
           }

           let heartImageName = isFavorite ? "heart.fill" : "heart"
           let heartImage = UIImage(systemName: heartImageName)?.withRenderingMode(.alwaysTemplate)
           favIcon.setImage(heartImage, for: .normal)
           favIcon.tintColor = isFavorite ? UIColor(named: "DarkPurple") : UIColor.gray
       }

       func configureFavoriteLeagueCell(league: LocalLeague) {
           leagueName.text = league.leagueName
           leagueCountry.text = league.sportType

           let heartImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
           favIcon.setImage(heartImage, for: .normal)
           favIcon.tintColor = UIColor(named: "DarkPurple")

           if let leagueUrl = URL(string: league.leagueLogo ?? " ") {
               leagueImage.kf.setImage(with: leagueUrl, placeholder: UIImage(systemName: "league"))
           }
       }
       
       @IBAction func addToFavorite(_ sender: Any) {
           let isCurrentlyFavorite = (favIcon.tintColor == UIColor(named: "DarkPurple"))
           if isCurrentlyFavorite {
               favIcon.tintColor = .gray
           } else {
               favIcon.tintColor = UIColor(named: "DarkPurple")
           }
           onAddToFavorite?(isCurrentlyFavorite)
       }
    
}
