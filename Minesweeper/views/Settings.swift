//
//  Properties.swift
//  Minesweeper
//
//  Created by Juan Gómez on 30/08/23.
//

import Foundation

struct TileProperty: Decodable {
    
    private var _width: Int?
    private var _height: Int?
    private var _backgroundColor: String?
    
    var width: Int { return self._width ?? DEFAULT_TILE_WIDTH }
    var height: Int { return self._height ?? DEFAULT_TILE_HEIGHT }
    var backgroundColor: String { return self._backgroundColor ?? DEFAULT_TILE_COLOR }
    
    enum CodingKeys: String, CodingKey {
        case _width = "width"
        case _height = "height"
        case _backgroundColor = "backgroundColor"
    }
}


struct Settings: Decodable {
    private var _levels: [String: LevelProperty]?
    private var _tile: TileProperty?
    
    enum CodingKeys: String, CodingKey {
        case _levels = "levels"
        case _tile = "tile"
    }
    
    init() {
        do {
            let path = Bundle.main.path(forResource: "settings", ofType: "plist")!
            let url = URL(fileURLWithPath: path)
            let plistData = try Data(contentsOf: url)
            self = try PropertyListDecoder().decode(Settings.self, from: plistData)
        } catch {
            debugPrint(error)
        }
    }
    
    var levels: [String: LevelProperty] { self._levels ?? [:]}
    
    var tile: TileProperty { self._tile ?? TileProperty() }
}
