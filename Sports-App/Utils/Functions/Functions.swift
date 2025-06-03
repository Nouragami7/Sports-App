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
    
    static func getCurrentDate() -> String {
        
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        let shortDate = dateFormatter.string(from: date)
       return shortDate
    }
    
    static func getDate(yearOffset: Int = 0) -> String {
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        
        if let adjustedDate = calendar.date(byAdding: .year, value: yearOffset, to: date) {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: adjustedDate)
        }
        
        return ""
    }

}
