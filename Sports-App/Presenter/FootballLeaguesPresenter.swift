//
//  FootballLeaguesPresenter.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import Foundation

class FooballLeaguesPresenter{
    var footballLeagueVC : LeaguesProtocol?
    
    init(footballLeagueVC: LeaguesProtocol? = nil) {
        self.footballLeagueVC = footballLeagueVC
    }
    
    func getFootballLeagues(){
        FootballNetworkService.fetchFootballLeagues(){
            result in
            if let footballLeaguesResults = result{
                self.footballLeagueVC?.renderToView(result: footballLeaguesResults)
            }else{
                print("Failed to feach football leagues")
            }
        }
    }
}
