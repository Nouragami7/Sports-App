//
//  FakeNetworkService.swift
//  Sports-AppTests
//
//  Created by macOS on 05/06/2025.
//

import Foundation
@testable import Sports_App

class FakeNetworkService {

    var shouldReturnData: Bool

    init(shouldReturnData: Bool) {
        self.shouldReturnData = shouldReturnData
    }

    func fetchLeagues(for sport: String, completionHandler: @escaping (LeaguesResponse?) -> Void) {
        if shouldReturnData {
            let fakeLeagues = [
                Leagues(
                    league_key: 1,
                    league_name: "Fake Premier League",
                    country_key: 123,
                    country_name: "Fakeland",
                    league_year: "2025",
                    league_logo: "https://fake.com/logo.png",
                    country_logo: "https://fake.com/country_logo.png"
                )
            ]
            let response = LeaguesResponse(result: fakeLeagues)
            completionHandler(response)
        } else {
            completionHandler(nil)
        }
    }
    
    
    func fetchUpcommingEvents(from: String, to: String, for sport: String, leagueId: String, completionHandler: @escaping (FixturesResponse?) -> Void) {
        if shouldReturnData {
            let fakeUpComingEvents: [Fixture] = []
            let response = FixturesResponse(success: 1, result: fakeUpComingEvents)
            completionHandler(response)
        } else {
            completionHandler(nil)
        }
    }
    
    func fetchTeams(for sport: String, leagueId: String, completionHandler: @escaping (TeamsResponse?) -> Void) {
            if shouldReturnData {
                let fakeTeams = [
                    Teams(team_key: 1, team_name: "Fake United", team_logo: "https://fake.com/logo.png")
                ]
                let response = TeamsResponse(success: 1, result: fakeTeams)
                completionHandler(response)
            } else {
                completionHandler(nil)
            }
        }
    

}

