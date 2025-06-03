//
//  UpCommingEventsCollectionViewCell.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import UIKit

class PastMatchEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var awayTeamTitle: UILabel!
    @IBOutlet weak var homeTeamTitle: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var awayTeam: UIImageView!
    @IBOutlet weak var homeTeam: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 90/255, green: 60/255, blue: 130/255, alpha: 1).cgColor,
            UIColor(red: 60/255, green: 30/255, blue: 100/255, alpha: 1).cgColor,
            UIColor(red: 25/255, green: 10/255, blue: 50/255, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = 16

        contentView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        contentView.layer.insertSublayer(gradientLayer, at: 0)

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6

        layer.cornerRadius = 16
        layer.masksToBounds = true

        score.font = UIFont.boldSystemFont(ofSize: 28)
        score.textColor = .white
        score.textAlignment = .center

        eventDate.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        eventDate.textColor = .white
        eventDate.textAlignment = .center
    

        eventTitle.font = UIFont.boldSystemFont(ofSize: 16)
        eventTitle.textColor = .white

        homeTeamTitle.font = UIFont.boldSystemFont(ofSize: 16)
        awayTeamTitle.font = UIFont.boldSystemFont(ofSize: 16)
        homeTeamTitle.textColor = .white
        awayTeamTitle.textColor = .white
    }

        
        override func prepareForReuse() {
            super.prepareForReuse()
            score.isHidden = false
            homeTeam.isHidden = false
            awayTeam.isHidden = false
            homeTeamTitle.isHidden = false
            awayTeamTitle.isHidden = false
            eventDate.isHidden = false
            eventTitle.isHidden = false
            score.text = ""
        }

    func configurePastMatchCell(fixture:Fixture ,sportType:String) {
      
        eventDate.text = fixture.event_date
        score.text = fixture.event_final_result
        self.eventTitle.text = fixture.league_name

        if sportType == "Tennis"{
            homeTeamTitle.text = fixture.event_first_player ?? "Player One"
            awayTeamTitle.text = fixture.event_second_player ?? "Player Two"
            score.text = fixture.event_final_result

        }else if sportType == "Cricket"{
            homeTeamTitle.text = fixture.event_home_team
            awayTeamTitle.text = fixture.event_away_team
            
            let res = "\(fixture.event_home_final_result ?? "-") - \(fixture.event_away_final_result ?? "-") "
            score.text = res
            score.font = score.font.withSize(14)
            
            eventDate.text = fixture.event_date_start
        }else {
            homeTeamTitle.text = fixture.event_home_team
            awayTeamTitle.text = fixture.event_away_team
            eventDate.text = fixture.event_date
            score.text = fixture.event_final_result
            
        }
            if let hLogo = fixture.home_team_logo, let hURL = URL(string: hLogo) {
                    homeTeam.kf.setImage(with: hURL, placeholder: UIImage(systemName: "photo"))
                }
            if let aLogo = fixture.away_team_logo, let aURL = URL(string: aLogo) {
                    awayTeam.kf.setImage(with: aURL, placeholder: UIImage(systemName: "photo"))
                }
        }
}
