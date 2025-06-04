//
//  LeagueDetailsCollectionViewController.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeagueDetailsCollectionViewController: UICollectionViewController, DetailsProtocol  {

    var leagueId: String = ""
    var sportType:String = ""
    var presenter: LeaguesDetailsPresnter!
    var fixtures: [Fixture] = []
    var pastEvents:[Fixture] = []
    var teams:[Teams] = []
    var datec =  " "
    override func viewDidLoad() {
        super.viewDidLoad()
     
        presenter = LeaguesDetailsPresnter(detailsVC: self)
        DispatchQueue.main.async {
            self.presenter.getUpcomingFixtures(
                from: "2025-03-01",
                to: "2025-03-30",
//                from: AppFunctions.getDate(),
//                to: AppFunctions.getDate(yearOffset: 1),
                sport: self.sportType,
                leagueId: self.leagueId)
            
            self.presenter.getPastFixtures(
                from: "2025-02-01",
                to: "2025-03-01",
//                from: AppFunctions.getDate(yearOffset: -1),
//                to: AppFunctions.getDate(),
                sport: self.sportType,
                leagueId: self.leagueId)
            
            self.presenter.getTeams(sport: self.sportType, leagueId: self.leagueId)
            
        }
        let upcomminghNib = UINib(nibName: "UpCommingEventsCollectionViewCell", bundle: nil)
        collectionView.register(upcomminghNib, forCellWithReuseIdentifier: "upcommingCell")
        let matchNib = UINib(nibName: "PastMatchEventCollectionViewCell", bundle: nil)
        collectionView.register(matchNib, forCellWithReuseIdentifier: "matchCell")
        
        let teamNib = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
        collectionView.register(teamNib, forCellWithReuseIdentifier: "teamCell")
       

        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                switch sectionIndex {
                case 0 :
                    return self.upCommingEventsSection()
                case 1 :
                    return self.pastEventsSection()
                default:
                    return self.teamsSection()
                }
            }
            collectionView.setCollectionViewLayout(layout, animated: true)
            
            self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
              case 0 :
            return fixtures.isEmpty ? 1 : fixtures.count
              case 1 :
            return pastEvents.isEmpty ? 1 : pastEvents.count
              case 2:
            return teams.count
        
        default:
            return 10
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingCell", for: indexPath) as? UpCommingEventsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
                        if fixtures.isEmpty {
                            cell.score.text = "No"
                            cell.awayTeam.isHidden = true
                            cell.homeTeam.isHidden = true
                            cell.homeTeamTitle.isHidden = true
                            cell.awayTeamTitle.isHidden = true
                            cell.eventDate.isHidden = true
                            cell.eventTitle.isHidden = true
                            return cell
            
                        }
                        else{
                            let fixture = fixtures[indexPath.row]
            
                            cell.configureUpcommingEentsCell(fixture: fixture, sportType: sportType)
            }
        
                 return cell
             
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath) as? PastMatchEventCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if pastEvents.isEmpty {
                cell.score.text = "No events"
                cell.awayTeam.isHidden = true
                cell.homeTeam.isHidden = true
                cell.homeTeamTitle.isHidden = true
                cell.awayTeamTitle.isHidden = true
                cell.eventDate.isHidden = true
                cell.eventTitle.isHidden = true
                return cell
                
            }
            else{
                let fixture = pastEvents[indexPath.row]
                cell.configurePastMatchCell(fixture: fixture, sportType:sportType)
                return cell
            }
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? TeamCollectionViewCell else {
                return UICollectionViewCell()
            }
            let teams = teams[indexPath.row]
            cell.configure(with: teams)
        
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? TeamCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "TeamDetails", bundle: nil)
            if let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "teamDetailsScreen") as? TeamDetailsCollectionViewController {
                let selectedTeam = teams[indexPath.row]
                teamDetailsVC.coach = selectedTeam.coaches  ?? []
                teamDetailsVC.players = selectedTeam.players ?? []
                teamDetailsVC.teamName = selectedTeam.team_name
                teamDetailsVC.teamLogo = selectedTeam.team_logo
                teamDetailsVC.sportType = sportType
                self.navigationController?.pushViewController(teamDetailsVC, animated: true)
            }
        }
    }
    
    func upCommingEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .absolute(160)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 15)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        
        // header
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

       
    func pastEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .none
        // header
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

    func teamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120),
                                               heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0,
                                                      bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15,
                                                        bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
      
        // header
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
                withReuseIdentifier: "header",
                for: indexPath
            ) as? SectionHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }

            switch indexPath.section {
            case 0:
                headerView.titleLabel.text = "Upcoming Events"
            case 1:
                headerView.titleLabel.text = "Past Matches"
            case 2:
                headerView.titleLabel.text = "Teams"
            default:
                headerView.titleLabel.text = ""
            }

            return headerView
        }
        return UICollectionReusableView()
    }


    func renderPastEventsToView(result: FixturesResponse) {
        DispatchQueue.main.async {
            if let fixtures = result.result, !fixtures.isEmpty {
                self.pastEvents = fixtures
                self.collectionView.reloadData()
            } else {
                self.pastEvents = []
                self.collectionView.reloadData()
                print("No upcoming events found.")
                
            }
        }
    }
    
    func renderToView(result: FixturesResponse) {
        DispatchQueue.main.async {
            if let fixtures = result.result, !fixtures.isEmpty {
                self.fixtures = fixtures
                self.collectionView.reloadData()
            } else {
                self.fixtures = []
                self.collectionView.reloadData()
                print("No upcoming events found.")
                
            }

        }
        fixtures.forEach {
            print("\($0.event_home_team ?? "") vs \($0.event_away_team ?? "") on \($0.event_date ?? "")")
        }
    }
    
    func renderTeams(result: TeamsResponse) {
        DispatchQueue.main.async {
            self.teams = result.result
            self.collectionView.reloadData()
            
        }
    }

}

