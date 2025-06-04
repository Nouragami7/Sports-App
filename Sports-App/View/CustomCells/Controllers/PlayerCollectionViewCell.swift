//
//  PlayerCollectionViewCell.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerRating: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 30/255, green: 10/255, blue: 100/255, alpha: 0.3).cgColor
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.masksToBounds = false
        
    }
    
    func congiurePlayerCell(player: Players){
        playerName.text = player.player_name
        playerNumber.text = player.player_number ?? "No"
        playerAge.text = player.player_age ?? "-"
        playerRating.text = player.player_match_played ?? "Rating"
        playerType.text = player.player_type ?? "Player"
        
        if let imageUrlString = player.player_image,
           let imageUrl = URL(string: imageUrlString) {
            playerImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "player"))
        } else {
            playerImage.image = UIImage(named: "player")
        }
    }
}
