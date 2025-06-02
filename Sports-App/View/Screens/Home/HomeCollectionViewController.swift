//
//  HomeCollectionViewController.swift
//  Sports-App
//
//  Created by Ayat on 29/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    var sports: [Sport] = SportsData.sports
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sports"
       // self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
   
        // Configure layout
          /*    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                  layout.minimumLineSpacing = 16       // Vertical spacing between rows
                  layout.minimumInteritemSpacing = 8   // Horizontal spacing between columns
                  layout.scrollDirection = .vertical
                  layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
              }*/
     }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath)
        
               // Configure the cell appearance
               cell.layer.borderWidth = 1
               cell.layer.borderColor = UIColor.purple.cgColor
               cell.layer.cornerRadius = 24
               cell.layer.shadowColor = UIColor.black.cgColor
               cell.layer.shadowOpacity = 0.2
               cell.layer.shadowOffset = CGSize(width: 0, height: 3)
               cell.layer.shadowRadius = 5
               cell.layer.masksToBounds = false
               
               // Configure image view
               if let imageView = cell.viewWithTag(1) as? UIImageView {
                   imageView.image = UIImage(named: sports[indexPath.item].imageName)
                   imageView.layer.shadowColor = UIColor.black.cgColor
                   imageView.layer.shadowOpacity = 0.2
                   imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
                   imageView.layer.shadowRadius = 5
                   imageView.layer.masksToBounds = false
               }
               
               // Configure title label
               if let titleLabel = cell.viewWithTag(2) as? UILabel {
                   titleLabel.text = sports[indexPath.item].name
                   titleLabel.backgroundColor = UIColor.purple
                   titleLabel.textColor = .white
                   titleLabel.layer.cornerRadius = 12
                   titleLabel.clipsToBounds = true
               }
               
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSport = sports[indexPath.row].name
        switch(selectedSport) {
        case "Football", "Basketball", "Tennis", "Cricket":
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            leaguesVC.sport = selectedSport
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        default:
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let totalCellHeight = (collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).height * 2)
        let totalSpacing: CGFloat = 20 // line spacing
        let totalHeight = totalCellHeight + totalSpacing
        let verticalInset = max((collectionView.frame.height - totalHeight) / 2, 0)
        
        collectionView.contentInset = UIEdgeInsets(top: verticalInset, left: 8 , bottom: 0, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 30
        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / 2

        return CGSize(width: cellWidth, height: cellWidth)
    }


}
