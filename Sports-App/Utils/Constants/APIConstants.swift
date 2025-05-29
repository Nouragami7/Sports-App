//
//  APIConstants.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import Foundation
struct APIConstants {
    static let baseHost = "https://apiv2.allsportsapi.com"
    static let apiKey = "afe650891f63962c27d793d70154af38384bb840d4a0654e277f4bebfce19865"
    
    struct Parameters {
        static let apiKeyParam = "APIkey"
        static let met = "met"
    }
    
    struct Endpoints {
        static let leagues = "Leagues"
        static let teams = "Teams"
        static let fixtures = "Fixtures"
    }
}
