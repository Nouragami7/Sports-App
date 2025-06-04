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
             guard let fullResult = response?.result else {
                        print("Data is empty in Presenter")
                        return
                    }
             let limitedResult = Array(fullResult.prefix(10))
             var limitedResponse = response!
             limitedResponse.result = limitedResult

             self.detailsVC?.renderToView(result: limitedResponse)
         }
     }
    
    func getPastFixtures(from: String, to: String, sport: String, leagueId: String) {
      let leagueIdString = String(leagueId)

         LeaguesDetailsNetworkService.fetchUpcommingEvents(from: from, to: to, for: sport, leagueId: leagueIdString) { response in
             guard let fullResult = response?.result else {
                       print("Data is empty in Presenter")
                       return
                   }

                   let limitedResult = Array(fullResult.prefix(20))
                   var limitedResponse = response!
                   limitedResponse.result = limitedResult

                   self.detailsVC?.renderPastEventsToView(result: limitedResponse)
         }
     }
    
    func getTeams(sport: String, leagueId: String) {
        let leagueIdString = String(leagueId)
        
        LeaguesDetailsNetworkService.fetchTeams(for: sport, leagueId: leagueIdString) { response in
            guard (response?.result) != nil else {
                print("Error at fetching teams")
                return
            }
            self.detailsVC?.renderTeams(result: response!)
        }
    }

    
}
