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

class Perimeter: Sequence {
    private var _topLeft: Tile?
    private var _top: Tile?
    private var _topRight: Tile?
    private var _left: Tile?
    private var _right: Tile?
    private var _bottomLeft: Tile?
    private var _bottom: Tile?
    private var _bottomRight: Tile?
    
    private var _perimeter: [Tile?]
    private var _sum: Int
    
    var sum: Int { get { _sum } }
    
    init() {
        self._sum = 0
        self._perimeter = []
    }
    
    init(pos: Int, field: Field) {
        self._sum = 0
        self._perimeter = []
        self._topLeft = field[self._getTopLeftPos(pos, field.cols)]
        self._top = field[self._getTopPos(pos, field.cols)]
        self._topRight = field[self._getTopRightPos(pos, field.cols)]
        self._left = field[self._getLeftPos(pos, field.cols)]
        self._right = field[self._getRightPos(pos, field.cols)]
        self._bottomLeft = field[self._getBottomLeft(pos, field.cols)]
        self._bottom = field[self._getBottomPos(pos, field.cols)]
        self._bottomRight = field[self._getBottomRightPos(pos, field.cols)]
        self._perimeter = [
            self._topLeft,
            self._top,
            self._topRight,
            self._left,
            self._right,
            self._bottomLeft,
            self._bottom,
            self._bottomRight
        ]
        self._sum = self._perimeter.filter { $0?.isMined ?? false }.reduce(0, {sum, _ in sum + 1})
    }
    
    subscript(index: Int) -> Tile? {
        get {
            guard index > 0 && index < self._perimeter.count else {
                return nil
            }
            return self._perimeter[index]
        }
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

    private func _getBottomLeft(_ pos: Int, _ columns: Int) -> Int {
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
