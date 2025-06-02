//
//  FixturesNetoworkService.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import Foundation
import Alamofire

class LeaguesDetailsNetworkService: LeaguesDetailsNetworkProtocol {
    static func fetchUpcommingEvents(from: String, to: String, for sport: String,leagueId:String,completionHandler: @escaping (FixturesResponse?) -> Void) {
        
        let parameters = ["met": "Fixtures","from": from,
                          "to": to, "leagueId": leagueId]
        guard let url = AppFunctions.createURL(sport: sport.lowercased(), endpoint: APIConstants.Endpoints.fixtures, parameters: parameters) else {
               print("Invalid URL")
               completionHandler(nil)
               return
           }

        AF.request(url).responseDecodable(of: FixturesResponse.self) { response in
            switch response.result {
            case .success(let fixtureResonse):
                completionHandler(fixtureResonse)
                 print("JSON Response: \(fixtureResonse)")

            case .failure(let error):
                print("Alamofire error in fixure: \(error)")
                completionHandler(nil)
            }
        }
    }
    
    static func fetchTeams(for sport: String, leagueId: String, completionHandler: @escaping (TeamsResponse?) -> Void) {
        
        let parameters = ["met": "Teams","leagueId": leagueId]
        
        guard let url = AppFunctions.createURL(
            sport: sport.lowercased(),
            endpoint: APIConstants.Endpoints.teams,
            parameters: parameters
        ) else {
            print("Invalid URL")
            completionHandler(nil)
            return
        }
        print("\(url)+++++++++++++++sa3dawy++++++++++++")


        AF.request(url).responseDecodable(of: TeamsResponse.self) { response in
            switch response.result {
            case .success(let teamsResponse):
                print("Teams Response: \(teamsResponse)")
                completionHandler(teamsResponse)
            case .failure(let error):
                print("Alamofire error in teams: \(error)")
                completionHandler(nil)
            }
        }
    }

    
   

}

