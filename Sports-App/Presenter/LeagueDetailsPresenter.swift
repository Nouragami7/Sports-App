//
//  LeagueDetailsPresenter.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import Foundation
class LeaguesDetailsPresnter {
    var detailsVC: DetailsProtocol?

    init(detailsVC: DetailsProtocol? = nil) {
        self.detailsVC = detailsVC
    }

    func getUpcomingFixtures(from: String, to: String, sport: String, leagueId: String) {
      let leagueIdString = String(leagueId)

         LeaguesDetailsNetworkService.fetchUpcommingEvents(from: from, to: to, for: sport, leagueId: leagueIdString) { response in
             guard let fixtures = response?.result else {
                 print("errorrr in presentert")
                 return
             }
             self.detailsVC?.renderToView(result: response!)
         }
     }
    
    func getPastFixtures(from: String, to: String, sport: String, leagueId: String) {
      let leagueIdString = String(leagueId)

         LeaguesDetailsNetworkService.fetchUpcommingEvents(from: from, to: to, for: sport, leagueId: leagueIdString) { response in
             guard let fixtures = response?.result else {
                 print("errorrr in presentert")
                 return
             }
             self.detailsVC?.renderPastEventsToView(result: response!)
         }
     }
    
    func getTeams(sport: String, leagueId: String) {
        let leagueIdString = String(leagueId)
        
        LeaguesDetailsNetworkService.fetchTeams(for: sport, leagueId: leagueIdString) { response in
            guard let teams = response?.result else {
                print("Error at fetching teams")
                return
            }
            self.detailsVC?.renderTeams(result: response!)
            print("\(response) ++++sa3dawy2++++++++++++++++")
        }
    }

    
}
