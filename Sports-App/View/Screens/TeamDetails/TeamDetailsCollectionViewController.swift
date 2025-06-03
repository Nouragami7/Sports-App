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
    var sportType : String?

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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
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
            cell.configuerTeamDeatilCell(team:teamName, sport:sportType, logo:teamLogo, coachName:coach.first)
            return cell

        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let player = players[indexPath.row]
            cell.congiurePlayerCell(player:player )
           
            return cell
        }
    }

    func teamsInfo() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(130)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 15,
            bottom: 10, trailing: 15
        )
        
        section.orthogonalScrollingBehavior = .none
 
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "teamDetailsHeader",
                for: indexPath
            ) as? SectionHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }

            switch indexPath.section {
            case 0:
                headerView.titleLabel.text = "Team Info"
            case 1:
                headerView.titleLabel.text = "Team Players"
            default:
                headerView.titleLabel.text = ""
            }

            return headerView
        }
        return UICollectionReusableView()
    }


}
