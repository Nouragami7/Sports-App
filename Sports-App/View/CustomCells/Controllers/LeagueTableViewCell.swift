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
        
        // Rounded corners
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        // Border with dark purple color
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor(red: 60/255, green: 30/255, blue: 100/255, alpha: 1).cgColor

        // Shadow (3D elevation)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6

        // Make shadow show beyond contentView
        layer.masksToBounds = false
        
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor(white: 0.95, alpha: 1).cgColor
        ]
        gradient.cornerRadius = 12
        contentView.layer.insertSublayer(gradient, at: 0)

        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
