//
//  NetworkProtocol.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import Foundation

protocol FootballNetworkProtocol {
    static func fetchFootballLeagues(completionHandler: @escaping (FootballLeagueResponse?) -> Void)
}
