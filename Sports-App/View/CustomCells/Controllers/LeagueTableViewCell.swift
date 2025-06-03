//
//  LeagueTableViewCell.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var leagueCountry: UILabel!
    
    @IBOutlet weak var isFavourite: UIImageView!
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
        /*
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor(red: 60/255, green: 30/255, blue: 100/255, alpha: 1).cgColor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor(white: 0.95, alpha: 1).cgColor
        ]
        gradient.cornerRadius = 12
        contentView.layer.insertSublayer(gradient, at: 0)
*/
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
    }
    func configureLeagueCell(league:Leagues, sportType:String){
        leagueName.text = league.league_name
        if sportType == "Cricket" {
            leagueCountry.text = league.league_year
        } else {
            leagueCountry.text = league.country_name
        }
        
        if let leagueUrl = URL(string: league.league_logo ?? " "){
            leagueImage.kf.setImage(with: leagueUrl, placeholder: UIImage(systemName: "league"))
        }
    }
}
