//
//  Field.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import Foundation

@Observable 
class Field {
    
    private let _ROWS: Int
    private let _COLS: Int
    private let _MINES: Int
    private let _FIELD: [Tile]
    
    private var _onGameFinish: (_ won: Bool) -> Void
    
    private var _won: Bool { self._FIELD.filter{ !$0.isToggled }.count == self._MINES }
    private var _locked: Int { self._FIELD.filter{ tile in tile.isLocked }.count }
    
    var rows: Int { self._ROWS }
    var cols: Int { self._COLS }
    var totalMines: Int { self._MINES }
    var remainingMines: Int {
        let locked = self._FIELD.filter{ tile in tile.isLocked }.count
        let total = self._MINES - locked
        return total >= 0 ? total : 0
    }
    
    init(level: Level = Level.BEGINNER, settings: Settings, onGameFinish: @escaping (_ won: Bool) -> Void) {
        let properties = settings.levels[level.rawValue] ?? LevelProperty(rows: DEFAULT_LEVEL_ROWS, columns: DEFAULT_LEVEL_COLUMNS, mines: DEFAULT_LEVEL_MINES)
        self._ROWS = properties.rows
        self._COLS = properties.columns
        self._MINES = properties.mines
        self._FIELD = (0...(self._ROWS * self._COLS)).map { Tile(pos: $0) }
        self._onGameFinish = onGameFinish
        self._generateField()
    }
    
    subscript(index: Int) -> Tile? {
        guard index >= 0 && index < self._FIELD.count else {
            return nil
        }
        return self._FIELD[index]
    }
    
    private func _generateField() -> Void {
        self._mineField()
        self._FIELD.forEach { tile in
            tile.perimeter = Perimeter(pos: tile.pos, field: self)
            tile.addToggleCallback  { event in
                if event == .MINED {
                    self._onGameFinish(false)
                } else if self._won {
                    self._onGameFinish(true)
                }
            }
        }
    }
    
    private func _mineField() -> Void {
        let max = self._ROWS * self._COLS - 1
        var i = 0
        repeat {
            let pos = Int.random(in: (0...max))
            if !self._FIELD[pos].isMined {
                self._FIELD[pos].mine()
                i += 1
            }
        } while i < self._MINES
    }
}
