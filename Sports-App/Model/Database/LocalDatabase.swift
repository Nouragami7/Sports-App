import Foundation
import CoreData
import UIKit

class LocalDatabase {
    static let database = LocalDatabase()
    private let context: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }

    func addLeagueToFavorite(league: LocalLeague) {
        guard let leagueEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: context) else {
            print("Cannot get FavoriteLeague entity")
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %@", league.leagueKey ?? "")

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let leagueObject = NSManagedObject(entity: leagueEntity, insertInto: context)
                leagueObject.setValue(league.leagueName, forKey: "leagueName")
                leagueObject.setValue(league.leagueLogo, forKey: "leagueLogo")
                leagueObject.setValue(league.leagueKey, forKey: "leagueKey")
                leagueObject.setValue(league.sportType, forKey: "sportType")
                leagueObject.setValue(league.isFav, forKey: "isFav")

                try context.save()
                print("League added to favorites.")
            } else {
                print("League already exists in favorites.")
            }
        } catch {
            print("Failed to add league to favorites: \(error.localizedDescription)")
        }
    }
    
    func getFavoriteLeagues(handler: @escaping (_ data: [LocalLeague]) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "isFav == %@", NSNumber(value: true))

        var favList: [LocalLeague] = []

        do {
            let result = try context.fetch(fetchRequest)
            for item in result {
                let newItem = LocalLeague(
                    leagueKey:item.value(forKey: "leagueKey") as? String,
                    leagueName: item.value(forKey: "leagueName") as? String,
                    leagueLogo: item.value(forKey: "leagueLogo") as? String,
                    sportType: item.value(forKey: "sportType") as? String,
                    isFav: item.value(forKey: "isFav") as? Bool ?? false)


                favList.append(newItem)
            }

            handler(favList)
            print("Fetched \(favList.count) favorite leagues from Core Data")
        } catch {
            print("Cannot fetch favorite leagues from Core Data: \(error.localizedDescription)")
        }
    }
    
    func removeLeagueFromFavorite(league: LocalLeague) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %@", league.leagueKey ?? "")

        do {
            let items = try context.fetch(fetchRequest)
            
            if let leagueItem = items.first {
                context.delete(leagueItem)
                try context.save()
                print("Removed from favorites successfully.")
            } else {
                print("League not found in favorites.")
            }
        } catch let error as NSError {
            print("Failed to remove from favorites: \(error), \(error.userInfo)")
        }
    }

    func isLeagueFavorite(leagueKey: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %@", leagueKey)

        do {
            let items = try context.fetch(fetchRequest)
            if let leagueItem = items.first,
               let isFav = leagueItem.value(forKey: "isFav") as? Bool {
                return isFav
            }
        } catch {
            print("Failed to fetch league favorite status: \(error)")
        }

        return false
    }

}
