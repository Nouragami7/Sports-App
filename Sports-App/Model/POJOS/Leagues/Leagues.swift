//
//  Leagues.swift
//  Sports-App
//
//  Created by macOS on 30/05/2025.
//

import Foundation

struct Leagues:Decodable {
    var league_key : Int
    var league_name :String
    var country_key : Int?
    var country_name : String?
    var league_year : String?
    var league_logo : String?
    var country_logo : String?
    
}
