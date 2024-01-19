//
//  Perimeter.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import Foundation

struct PerimeterIterator: IteratorProtocol {
    private let _perimeter: [Tile?]
    private var _pos: Int = 0
    
    init(_ perimeter: [Tile?]) {
        self._perimeter = perimeter
    }
    
    mutating func next() -> Tile? {
        let tiles = self._perimeter.filter { $0 != nil }
        
        guard self._pos < tiles.count else {
            return nil
        }
        
        let tile = tiles[self._pos];
        self._pos += 1
        
        return tile
    }
}

struct Perimeter: Sequence {
    
    private var _perimeter: [Tile]
    private var _sum: Int
    
    var sum: Int { _sum }
    
    private var coordinates: Dictionary<String, (_ pos: Int, _ columns: Int) -> Int> {
        return [
            "topLeft":      self._getTopLeftPos,
            "top":          self._getTopPos,
            "topRight":     self._getTopRightPos,
            "left":         self._getLeftPos,
            "right":        self._getRightPos,
            "bottomLeft":   self._getBottomLeftPos,
            "bottom":       self._getBottomPos,
            "bottomRight":  self._getBottomRightPos,
        ]
    }
    
    init() {
        self._sum = 0
        self._perimeter = []
    }
    
    init(pos: Int, field: Field) {
        self._sum = 0
        self._perimeter = []
        self.coordinates.forEach { element in
            let getter = element.value
            let tile = field[getter(pos, field.cols)]
            if tile != nil {
                self._perimeter.append(tile!)
            }
        }
        self._sum = self._perimeter.filter { $0.isMined }.reduce(0, {sum, _ in sum + 1})
    }
    
    subscript(index: Int) -> Tile? {
        guard index > 0 && index < self._perimeter.count else {
            return nil
        }
        return self._perimeter[index]
    }
    
    func makeIterator() -> PerimeterIterator {
        return PerimeterIterator(self._perimeter)
    }
    
    private func _getTopLeftPos(_ pos: Int, _ columns: Int) -> Int {
        guard pos % columns != 0 else {
            return -1;
        }
        return self._getTopPos(pos, columns) - 1
    }

    private func _getTopPos(_ pos: Int, _ columns: Int) -> Int {
        return pos - columns
    }

    private func _getTopRightPos(_ pos: Int, _ columns: Int) -> Int {
        guard pos % columns != columns - 1 else {
            return -1
        }
        return self._getTopPos(pos, columns) + 1
    }

    private func _getLeftPos(_ pos: Int, _ columns: Int) -> Int {
        guard pos % columns != 0 else {
            return -1
        }
        return pos - 1
    }

    private func _getRightPos(_ pos: Int, _ columns: Int) -> Int {
        guard pos % columns != columns - 1 else {
            return -1
        }
        return pos + 1
    }

    private func _getBottomLeftPos(_ pos: Int, _ columns: Int) -> Int {
        guard pos % columns != 0 else {
            return -1
        }
        return self._getBottomPos(pos, columns) - 1
    }

    private func _getBottomPos(_ pos: Int, _ columns: Int) -> Int {
        return pos + columns;
    }

    private func _getBottomRightPos(_ pos: Int, _ columns: Int) -> Int {
        guard pos % columns != columns - 1 else {
            return -1
        }
        return self._getBottomPos(pos, columns) + 1
    }
}
