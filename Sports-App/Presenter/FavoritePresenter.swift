//
//  FavoritePresenter.swift
//  Sports-App
//
//  Created by Ayat on 03/06/2025.
//

import Foundation

protocol FavoritePresenterProtocol {
    func addToFavorite(league:LocalLeague)
    
    func fetchFavoriteLeagues()
    func removeFromFavorite(league: LocalLeague)
    func isLeagueFavorite(leagueKey: String) -> Bool


}
protocol FavoriteViewProtocol  {
    func renderFavoriteUI(leagues: [LocalLeague])
}

class FavoritePresenter : FavoritePresenterProtocol{
    
    let db = LocalDatabase.database
    let view : FavoriteViewProtocol?
    
    init(view: FavoriteViewProtocol?) {
        self.view = view
    }
    
    func addToFavorite(league: LocalLeague) {
        db.addLeagueToFavorite(league: league)
    }
    
    
    func fetchFavoriteLeagues() {
        db.getFavoriteLeagues { data in
            self.view?.renderFavoriteUI(leagues: data)
        }
    }

    func removeFromFavorite(league: LocalLeague) {
        db.removeLeagueFromFavorite(league: league)
    }

    func isLeagueFavorite(leagueKey: String) -> Bool {
        return db.isLeagueFavorite(leagueKey: leagueKey)
    }

}
