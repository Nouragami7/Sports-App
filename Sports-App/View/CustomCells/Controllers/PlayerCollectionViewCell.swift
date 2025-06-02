//
//  PlayerCollectionViewCell.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerRating: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = false
        
               contentView.layer.borderWidth = 1
               contentView.layer.borderColor = UIColor.white.cgColor
               contentView.layer.masksToBounds = true
               layer.shadowOpacity = 1
               layer.shadowColor = nil
               layer.cornerRadius = 16
               layer.masksToBounds = true


    }
    
}
