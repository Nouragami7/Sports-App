//
//  UpCommingEventsCollectionViewCell.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
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
        
        // MARK: - Background Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 90/255, green: 60/255, blue: 130/255, alpha: 1).cgColor,   // Lighter dark
            UIColor(red: 60/255, green: 30/255, blue: 100/255, alpha: 1).cgColor,   // Mid-dark
            UIColor(red: 25/255, green: 10/255, blue: 50/255, alpha: 1).cgColor     // Deep dark
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = 16

        contentView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        contentView.layer.insertSublayer(gradientLayer, at: 0)

        // MARK: - Shadow and Corners
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6

        layer.cornerRadius = 16
        layer.masksToBounds = true

        // MARK: - Score Styling
        score.font = UIFont.boldSystemFont(ofSize: 28)
        score.textColor = .white
        score.textAlignment = .center

        // MARK: - Event Date Styling
        eventDate.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        eventDate.textColor = .white
        eventDate.textAlignment = .center
    

        // MARK: - Event Title
        eventTitle.font = UIFont.boldSystemFont(ofSize: 16)
        eventTitle.textColor = .white

        // MARK: - Team Titles
        homeTeamTitle.font = UIFont.boldSystemFont(ofSize: 16)
        awayTeamTitle.font = UIFont.boldSystemFont(ofSize: 16)
        homeTeamTitle.textColor = .white
        awayTeamTitle.textColor = .white
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.sublayers?.first(where: { $0 is CAGradientLayer })?.frame = contentView.bounds
    }

    
}
