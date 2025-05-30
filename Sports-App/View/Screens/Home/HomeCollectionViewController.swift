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
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
   
    
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

        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 24
        cell.layer.borderColor = UIColor.blue.cgColor
        
        (cell.viewWithTag(2) as! UILabel).text = sports[indexPath.item].name
        let sportImage = UIImage(named:sports[indexPath.item].imageName)
        (cell.viewWithTag(1)as! UIImageView).image = sportImage
        
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSport = sports[indexPath.row].name
        
        
        switch(selectedSport)
        {
        case "Football":
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        case "Basketball":
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        case "Tennis":
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        case "Cricket":
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        default:
            print("Deafult for now \(selectedSport)\n")
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
