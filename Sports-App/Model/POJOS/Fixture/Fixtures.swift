import Foundation

struct Fixture: Decodable {
    let event_key: String?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let event_away_team: String?
    let event_final_result: String?
    let event_status: String?
    let event_stadium: String?
    let event_referee: String?
    let event_round: String?
    let event_season: String?
    let event_live: String?

    let event_home_team_id: String?
    let event_away_team_id: String?

    let home_team_logo: String?
    let away_team_logo: String?

    let league_name: String?
    let league_key: String?
    let league_id: String?
    let league_logo: String?

    let country_name: String?
    let country_key: String?
    let country_logo: String?

    // Tennis
       let event_first_player: String?
       let event_second_player: String?
       let event_game_result: String?
    
    
    // Cricket
    let event_home_final_result: String?
    let event_away_final_result: String?
    let event_date_start: String?
    let sportType: String? 

    enum CodingKeys: String, CodingKey {
        case event_key, event_date, event_time, event_home_team, event_away_team, event_final_result, event_status, event_stadium, event_referee, event_round, event_season, event_live, event_home_team_id, event_away_team_id, home_team_logo, away_team_logo, league_name, league_key, league_id, league_logo, country_name, country_key, country_logo, sportType, event_home_final_result, event_away_final_result, event_first_player, event_second_player, event_game_result,event_date_start
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let eventKeyInt = try? container.decode(Int.self, forKey: .event_key) {
            event_key = String(eventKeyInt)
        } else {
            event_key = try? container.decode(String.self, forKey: .event_key)
        }
        event_date = try? container.decode(String.self, forKey: .event_date)
        event_time = try? container.decode(String.self, forKey: .event_time)
        event_home_team = try? container.decode(String.self, forKey: .event_home_team)
        event_away_team = try? container.decode(String.self, forKey: .event_away_team)
        event_final_result = try? container.decode(String.self, forKey: .event_final_result)
        event_status = try? container.decode(String.self, forKey: .event_status)
        event_stadium = try? container.decode(String.self, forKey: .event_stadium)
        event_referee = try? container.decode(String.self, forKey: .event_referee)
        event_round = try? container.decode(String.self, forKey: .event_round)
        event_season = try? container.decode(String.self, forKey: .event_season)
        event_live = try? container.decode(String.self, forKey: .event_live)
        event_home_team_id = try? container.decode(String.self, forKey: .event_home_team_id)
        event_away_team_id = try? container.decode(String.self, forKey: .event_away_team_id)
        home_team_logo = try? container.decode(String.self, forKey: .home_team_logo)
        away_team_logo = try? container.decode(String.self, forKey: .away_team_logo)
        league_name = try? container.decode(String.self, forKey: .league_name)
        league_key = try? container.decode(String.self, forKey: .league_key)
        league_id = try? container.decode(String.self, forKey: .league_id)
        league_logo = try? container.decode(String.self, forKey: .league_logo)
        country_name = try? container.decode(String.self, forKey: .country_name)
        country_key = try? container.decode(String.self, forKey: .country_key)
        country_logo = try? container.decode(String.self, forKey: .country_logo)
        sportType = try? container.decode(String.self, forKey: .sportType)
           event_first_player = try? container.decode(String.self, forKey: .event_home_team)
         event_second_player = try? container.decode(String.self, forKey: .event_away_team)
          event_game_result = try? container.decode(String.self, forKey: .event_final_result)
       
       
       // Cricket
      event_home_final_result = try? container.decode(String.self, forKey: .event_home_final_result)

     event_away_final_result = try? container.decode(String.self, forKey: .event_away_final_result)
        event_date_start = try? container.decode(String.self, forKey: .event_date_start)

    }
}
