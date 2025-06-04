//
//  FixturesResponse.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import Foundation

struct FixturesResponse: Decodable {
    let success: Int?
    var result: [Fixture]?
}
