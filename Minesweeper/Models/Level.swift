//
//  Levels.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import Foundation

enum Level: String, Codable {
    case BEGINNER = "beginner"
    case INTERMEDIATE = "intermediate"
    case EXPERT = "expert"
}


struct LevelProperty: Codable {
    var rows: Int
    var columns: Int
    var mines: Int
}
