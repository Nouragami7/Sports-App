//
//  TeamDetailsCollectionViewController.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class TeamDetailsCollectionViewController: UICollectionViewController {
    
    var coach: [Coaches] = []
    var players : [Players] = []
    var teamLogo : String?
    var teamName : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let nib = UINib(nibName: "TeamLogoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "teamInfoCell")
        
        let playersNib = UINib(nibName: "PlayerCollectionViewCell", bundle: nil)
        collectionView.register(playersNib, forCellWithReuseIdentifier: "playerCell")
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                switch sectionIndex {
                case 0 :
                    return self.teamsInfo()
                default:
                    return self.playersSection()
                }
            }
            collectionView.setCollectionViewLayout(layout, animated: true)
            
            self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     switch section{
        case 0 :
            return 1
        default:
            return players.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamInfoCell", for: indexPath) as? TeamLogoCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.teamName.text = teamName

            if let teamLogoUrl = URL(string: teamLogo ?? "") {
                cell.teamLogo.kf.setImage(with: teamLogoUrl, placeholder: UIImage(systemName: "league"))
            }

            if let firstCoach = coach.first {
                cell.teamCoach.text = firstCoach.coach_name
            } else {
                cell.teamCoach.text = "No coach info"
            }

            return cell

        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let player = players[indexPath.row]
               cell.playerName.text = player.player_name ?? "N/A"
               cell.playerNumber.text = "No: \(player.player_number ?? "-")"
               cell.playerAge.text = "Age: \(player.player_age ?? "-")"
               cell.playerRating.text = "Played: \(player.player_match_played ?? "-")"

               if let imageUrlString = player.player_image,
                  let imageUrl = URL(string: imageUrlString) {
                   cell.playerImage.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "person.crop.circle"))
               } else {
                   cell.playerImage.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
               }
            return cell
        }
    }

    func teamsInfo()-> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                 , heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7)
                                                  , heightDimension: .absolute(225))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                          , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                         , bottom: 0, trailing: 15)
           
           
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                           , bottom: 10, trailing: 0)
           section.orthogonalScrollingBehavior = .continuous
           section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
           }
           return section
       }
    
    
    func playersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.interGroupSpacing = 5

        return section
    }

       

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
