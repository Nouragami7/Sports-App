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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LeaguesDetailsPresnter(detailsVC: self)
        DispatchQueue.main.async {
            self.presenter.getUpcomingFixtures(
                from: "2025-03-01",
                to: "2025-03-10",
                sport: self.sportType,
                leagueId: self.leagueId)
            
            self.presenter.getPastFixtures(
                from: "2025-02-01",
                to: "2025-02-28",
                sport: self.sportType,
                leagueId: self.leagueId)
            
        }

        let nib = UINib(nibName: "UpCommingEventsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "upcommingCell")
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                switch sectionIndex {
                case 0 :
                    return self.upCommingEventsSection()
                case 1 :
                    return self.pastEventsSection()
                default:
                    return self.upCommingEventsSection()
                }
            }
            collectionView.setCollectionViewLayout(layout, animated: true)
            
            // Register cell classes
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
              default:
                  return 12
              }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch indexPath.section {
               case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingCell", for: indexPath) as? UpCommingEventsCollectionViewCell else {
                     return UICollectionViewCell()
                 }
            
            if fixtures.isEmpty {
                cell.score.text = "No Upcomming Events!"
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
                  
                  if let homeTeamUrl = URL(string: fixture.home_team_logo ?? " "){
                      cell.homeTeam.kf.setImage(with: homeTeamUrl, placeholder: UIImage(systemName: "league"))
                  }
                  if let awayTeamUrl = URL(string: fixture.away_team_logo ?? " "){
                      cell.awayTeam.kf.setImage(with: awayTeamUrl, placeholder: UIImage(systemName: "league"))
                  }
                    cell.homeTeamTitle.text = fixture.event_home_team
                    cell.awayTeamTitle.text = fixture.event_away_team
                    cell.eventDate.text = fixture.event_date
                    cell.eventTitle.text = fixture.league_name
                         return cell
            }
        case 1:
            
         

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingCell", for: indexPath) as? UpCommingEventsCollectionViewCell else {
                     return UICollectionViewCell()
                 }
            
            
            if pastEvents.isEmpty {
                cell.score.text = "No Upcomming Events!"
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
                  
                  if let homeTeamUrl = URL(string: fixture.home_team_logo ?? " "){
                      cell.homeTeam.kf.setImage(with: homeTeamUrl, placeholder: UIImage(systemName: "league"))
                  }
                  if let awayTeamUrl = URL(string: fixture.away_team_logo ?? " "){
                      cell.awayTeam.kf.setImage(with: awayTeamUrl, placeholder: UIImage(systemName: "league"))
                  }
                    cell.homeTeamTitle.text = fixture.event_home_team
                    cell.awayTeamTitle.text = fixture.event_away_team
                    cell.eventDate.text = fixture.event_date
                    cell.eventTitle.text = fixture.league_name
                cell.score.text = fixture.event_final_result
                         return cell
            }
          
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath)
            return cell
            
        }
 
    }

    func upCommingEventsSection()-> NSCollectionLayoutSection {
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
       
    func pastEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 15
       
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
