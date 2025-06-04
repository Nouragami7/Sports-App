//
//  Teams.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import Foundation

struct Teams:Decodable{
    var team_key : Int
    var team_name : String?
    var team_logo : String?
    var players : [Players]?
    var coaches : [Coaches]?
}
