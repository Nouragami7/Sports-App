//
//  Functions.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import Foundation
class AppFunctions{
    
    static func createURL(sport: String, endpoint: String, parameters: [String: String]) -> URL? {
        var components = URLComponents(string: "\(APIConstants.baseHost)/\(sport)/")
        var queryItems = [URLQueryItem(name: "APIkey", value: APIConstants.apiKey)]
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components?.queryItems = queryItems
        print("URL: \(components?.url?.absoluteString ?? "Invalid URL")")

        return components?.url
    }
}
