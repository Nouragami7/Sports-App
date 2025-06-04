//
//  SportCollectionViewCell.swift
//  Sports-App
//
//  Created by Ayat on 04/06/2025.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
   
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportImageView: UIImageView!
    
    
    func configure(with sport: Sport) {
           sportImageView.image = UIImage(named: sport.imageName)
           sportImageView.contentMode = .scaleAspectFill
           sportImageView.clipsToBounds = true
           
           sportLabel.text = sport.name
           sportLabel.backgroundColor = UIColor(red: 0.9, green: 0.8, blue: 1.0, alpha: 0.6)
           sportLabel.textColor = .black
           sportLabel.clipsToBounds = true
   
        
        layer.borderWidth = 0.5
        sportLabel.backgroundColor = UIColor(red: 0.9, green: 0.8, blue: 1.0, alpha:1.0)
       layer.cornerRadius = 12
       layer.shadowColor = UIColor.lightGray.cgColor
       layer.shadowOpacity = 0.2
       layer.shadowOffset = CGSize(width: 0, height: 3)
       layer.shadowRadius = 2
       layer.masksToBounds = false
       }
}
