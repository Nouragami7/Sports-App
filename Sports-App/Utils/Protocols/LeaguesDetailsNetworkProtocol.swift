//
//  LeaguesDetailsNetworkProtocol.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import Foundation
protocol LeaguesDetailsNetworkProtocol{
    static func fetchUpcommingEvents(from: String, to: String, for sport: String,leagueId:String,completionHandler: @escaping (FixturesResponse?) -> Void)
    
    static func fetchTeams(for sport: String, leagueId: String, completionHandler: @escaping (TeamsResponse?) -> Void)
}
