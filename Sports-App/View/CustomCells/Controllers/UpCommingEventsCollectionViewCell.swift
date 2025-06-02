//
//  UpCommingEventsCollectionViewCell.swift
//  Sports-App
//
//  Created by Ayat on 01/06/2025.
//

import UIKit

class UpCommingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var awayTeamTitle: UILabel!
    @IBOutlet weak var homeTeamTitle: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var awayTeam: UIImageView!
    @IBOutlet weak var homeTeam: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        layer.cornerRadius = 16

        let purple = UIColor(red: 30/255, green: 10/255, blue: 50/255, alpha: 1)

        score.font = UIFont.boldSystemFont(ofSize: 28)
        score.textColor = purple
        score.textAlignment = .center

        eventDate.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        eventDate.textColor = purple
        eventDate.textAlignment = .center

        eventTitle.font = UIFont.boldSystemFont(ofSize: 16)
        eventTitle.textColor = purple

        homeTeamTitle.font = UIFont.boldSystemFont(ofSize: 16)
        awayTeamTitle.font = UIFont.boldSystemFont(ofSize: 16)
        homeTeamTitle.textColor = purple
        awayTeamTitle.textColor = purple
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

        func configureUpcommingEentsCell(hTeam: String?, hLogo: String?, aTeam: String?, aLogo: String?, mDate: String?, eventTitle: String?) {
            homeTeamTitle.text = hTeam
            awayTeamTitle.text = aTeam
            eventDate.text = mDate
            self.eventTitle.text = eventTitle
            score.text = "VS"

            if let hLogo = hLogo, let hURL = URL(string: hLogo) {
                homeTeam.kf.setImage(with: hURL, placeholder: UIImage(systemName: "photo"))
            }
            if let aLogo = aLogo, let aURL = URL(string: aLogo) {
                awayTeam.kf.setImage(with: aURL, placeholder: UIImage(systemName: "photo"))
            }
        }

  

}
