//
//  TeamLogoCollectionViewCell.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import UIKit

class TeamLogoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportType: UILabel!
    @IBOutlet weak var teamCoach: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6

        layer.cornerRadius = 16
        layer.masksToBounds = true
//        teamLogo.clipsToBounds = true


    }
    override func layoutSubviews() {
            super.layoutSubviews()

            teamLogo.layer.cornerRadius = 30
        }

          }
      
