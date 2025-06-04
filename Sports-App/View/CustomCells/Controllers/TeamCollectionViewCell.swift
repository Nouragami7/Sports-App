//
//  TeamCollectionViewCell.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
               contentView.layer.masksToBounds = true
               
           
               layer.shadowColor = UIColor.black.cgColor
               layer.shadowOpacity = 0.25
               layer.shadowOffset = CGSize(width: 0, height: 4)
               layer.shadowRadius = 6
               layer.masksToBounds = false
               
               teamLogo.layer.cornerRadius = teamLogo.frame.height/2
               teamLogo.clipsToBounds = true
               teamLogo.contentMode = .scaleAspectFit
           }
           
    func configure(with team: Teams) {
               teamName.text = team.team_name
        
               
               if let logoString = team.team_logo, let logoUrl = URL(string: logoString) {
                   teamLogo.kf.setImage(with: logoUrl, placeholder: UIImage(systemName: "league"))
               } else {
                   teamLogo.image = UIImage(systemName: "league")
               }
               
               contentView.backgroundColor = UIColor(
                   red: CGFloat.random(in: 0.9...1),
                   green: CGFloat.random(in: 0.9...1),
                   blue: CGFloat.random(in: 0.9...1),
                   alpha: 1.0
               )
           }
           
           override func prepareForReuse() {
               super.prepareForReuse()
               teamLogo.image = nil
               teamName.text = ""
               contentView.backgroundColor = .clear
           }
       }
