//
//  LocalLeague.swift
//  Sports-App
//
//  Created by Ayat on 03/06/2025.
//

import Foundation
struct LocalLeague{
    var leagueName: String?
    var leagueLogo: String?
    var leagueKey: String?
    var sportType: String?
    var isFav: Bool?
    
    init(leagueKey: String?, leagueName: String?, leagueLogo: String?, sportType: String?, isFav: Bool?) {
        self.leagueKey = leagueKey
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        self.sportType = sportType
        self.isFav = isFav
    }

}
