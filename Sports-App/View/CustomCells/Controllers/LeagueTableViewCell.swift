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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
