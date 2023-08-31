//
//  Properties.swift
//  Minesweeper
//
//  Created by Juan Gómez on 30/08/23.
//

import Foundation

struct Dimension: Decodable {
    var width: Int
    var height: Int
}


struct Settings: Decodable {
    private var _levels: [String: LevelProperty]
    private var _tile: Dimension
    
    static let shared = Settings()
    
    enum CodingKeys: String, CodingKey {
        case _levels = "levels"
        case _tile = "tile"
    }
    
    private init() {
        print("Loading")
        self._levels = [:]
        self._tile = Dimension(width: 32, height: 32)
        do {
            let path = Bundle.main.path(forResource: "settings", ofType: "plist")!
            let url = URL(fileURLWithPath: path)
            let plistData = try Data(contentsOf: url)
            self = try PropertyListDecoder().decode(Settings.self, from: plistData)
        } catch {
            print(error)
        }
    }
    
    var levels: [String: LevelProperty] {
        get { self._levels }
    }
    
    var tile: Dimension {
        get { self._tile }
    }
}
