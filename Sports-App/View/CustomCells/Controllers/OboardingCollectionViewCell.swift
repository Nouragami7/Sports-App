//
//  OboardingCollectionViewCell.swift
//  Sports-App
//
//  Created by macOS on 03/06/2025.
//

import UIKit

class OboardingCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with item: OnboardingItem) {
           image.image = UIImage(named: item.imageName)
           titleLabel.text = item.title
           descriptionLabel.text = item.description
       }

}
