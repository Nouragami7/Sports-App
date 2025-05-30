//
//  Sport.swift
//  Sports-App
//
//  Created by Ayat on 29/05/2025.
//

import Foundation
struct Sport {
    let name: String
    let imageName: String
}

struct SportsData {
    static let sports: [Sport] = [
        Sport(name: "Football", imageName: "football"),
        Sport(name: "Basketball", imageName: "basketball"),
        Sport(name: "Tennis", imageName: "tennis"),
         Sport(name: "Cricket", imageName: "cricket"),
     ]
}
