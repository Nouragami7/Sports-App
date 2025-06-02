//
//  NetworkService.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import Foundation
import Alamofire

class LeaguesNetworkService: LeaguesNetworkProtocol {
    static func fetchLeagues(for sport: String,completionHandler: @escaping (LeaguesResponse?) -> Void) {
        let parameters = ["met": "Leagues"]
        guard let url = AppFunctions.createURL(sport: sport.lowercased(), endpoint: APIConstants.Endpoints.leagues, parameters: parameters) else {
               print("Invalid URL")
               completionHandler(nil)
               return
           }

        AF.request(url).responseDecodable(of: LeaguesResponse.self) { response in
            switch response.result {
            case .success(let leaguesResponse):
                completionHandler(leaguesResponse)
                print(leaguesResponse)
            case .failure(let error):
                print("Alamofire error: \(error)")
                completionHandler(nil)
            }
        }
    }
    

}

