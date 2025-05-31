//
//  LeaguesPresenter.swift
//  Sports-App
//
//  Created by macOS on 30/05/2025.
//

import Foundation
class LeaguesPresnter {
    var leagueVC: LeaguesProtocol?

    init(leagueVC: LeaguesProtocol) {
        self.leagueVC = leagueVC
    }

    func getFootballLeagues(for sport: String) {
        LeaguesNetworkService.fetchLeagues(for: sport) { response in
            if let response = response {
                self.leagueVC?.renderToView(result: response)
            } else {
                print("Failed to fetch leagues")
            }
        }
    }
}
