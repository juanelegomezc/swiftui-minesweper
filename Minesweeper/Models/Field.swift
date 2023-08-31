//
//  Field.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import Foundation

class Field: ObservableObject {
    let rows: Int
    let cols: Int
    private var _mines: Int
    private var _field: [Tile]
    
    init(level: Level = Level.BEGINNER) {
        let settings = Settings.shared
        let properties = settings.levels[level.rawValue] ?? LevelProperty(rows: 9, columns: 9, mines: 10)
        self.rows = properties.rows
        self.cols = properties.columns
        self._mines = properties.mines
        self._field = (0...(self.rows * self.cols)).map { Tile(pos: $0) }
        self._generateField()
    }
    
    subscript(index: Int) -> Tile? {
        get {
            guard index >= 0 && index < self._field.count else {
                return nil
            }
            return self._field[index]
        }
    }
    
    private func _generateField() -> Void {
        self._mineField()
        self._field.forEach { tile in
            tile.perimeter = Perimeter(pos: tile.pos, field: self)
        }
    }
    
    private func _mineField() -> Void {
        let max = self.rows * self.cols - 1
        var i = 0
        repeat {
            let pos = Int.random(in: (0...max))
            if !self._field[pos].isMined {
                self._field[pos].mine()
                i += 1
            }
        } while i < self._mines
    }
}
