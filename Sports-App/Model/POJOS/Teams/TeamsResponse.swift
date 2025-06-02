//
//  TeamsResponse.swift
//  Sports-App
//
//  Created by macOS on 31/05/2025.
//

import Foundation
struct TeamsResponse:Decodable{
    var success : Int
    var result : [Teams]
}
