//
//  FixturesNetoworkService.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import Foundation
import Alamofire
protocol FixturesNetworkProtocol{
    static func fetchUpcommingEvents(from: String, to: String, for sport: String,leagueId:String,completionHandler: @escaping (FixturesResponse?) -> Void)
    
}


class FixturesNetworkService: FixturesNetworkProtocol {
    static func fetchUpcommingEvents(from: String, to: String, for sport: String,leagueId:String,completionHandler: @escaping (FixturesResponse?) -> Void) {
        
        let parameters = ["met": "Fixtures","from": from,
                          "to": to, "leagueId": leagueId]
        guard let url = createURL(sport: sport.lowercased(), endpoint: APIConstants.Endpoints.fixtures, parameters: parameters) else {
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
    
    private static func createURL(sport: String, endpoint: String, parameters: [String: String]) -> URL? {
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

