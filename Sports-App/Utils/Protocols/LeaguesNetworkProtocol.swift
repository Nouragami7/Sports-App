//
//  LeaguesNetworkProtocol.swift
//  Sports-App
//
//  Created by macOS on 30/05/2025.
//

import Foundation

protocol LeaguesNetworkProtocol {
    static func fetchLeagues(for sport: String,completionHandler: @escaping (LeaguesResponse?) -> Void)
}
