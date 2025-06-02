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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LeaguesDetailsPresnter(detailsVC: self)
        DispatchQueue.main.async {
            self.presenter.getUpcomingFixtures(
                from: "2025-06-02",
                to: "2025-12-30",
                sport: self.sportType,
                leagueId: self.leagueId)
            
            self.presenter.getPastFixtures(
                from: "2025-01-01",
                to: "2025-06-01",
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


    // MARK: UICollectionViewDataSource

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
            
                            cell.configureUpcommingEentsCell(hTeam: fixture.event_home_team, hLogo: fixture.home_team_logo, aTeam: fixture.event_away_team , aLogo: fixture.away_team_logo, mDate: fixture.event_date, eventTitle: fixture.league_name)
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
                cell.configurePastMatchCell(hTeam: fixture.event_home_team, hLogo: fixture.home_team_logo, aTeam: fixture.event_away_team , aLogo: fixture.away_team_logo, mDate: fixture.event_date, mScore: fixture.event_final_result, eventTitle: fixture.league_name)
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
                teamDetailsVC.coach = selectedTeam.coaches
                teamDetailsVC.players = selectedTeam.players
                teamDetailsVC.teamName = selectedTeam.team_name
                teamDetailsVC.teamLogo = selectedTeam.team_logo
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
        
        return section
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
