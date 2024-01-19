//
//  Tile.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import Foundation
import SwiftUI

enum TileEvent {
    case MINED
    case TOGGLED
    case LOCKED
}

/// Represents a tile in the field
@Observable
class Tile {
    
    // Constants
    private let _POS: Int
    
    private var _isMined: Bool = false
    private var _value: Int = -1
    private var _perimeter: Perimeter
    private var _colors: [Color] = [
        Color(fromHex: "#00f"),     // Blue
        Color(fromHex: "#008000"),  // Green
        Color(fromHex: "#f00"),     // Red
        Color(fromHex: "#800080"),  // Purple
        Color(fromHex: "#800000"),  // Maroon
        Color(fromHex: "#40e0d0"),  // Turquoise
        Color(fromHex: "#000"),     // Black
        Color(fromHex: "#808080")   // Gray
    ]
    private var _toggleCallback: ((TileEvent) -> Void)? = nil
    
    private var _isToggled: Bool = false
    private var _isLocked: Bool = false
    
    // Getters
    var value: String {
        var value = ""
        if self._isMined {
            value = "💣"
        } else if (self._value > 0) {
            value = "\(self._value)"
        }
        return value
    }
    var pos: Int { self._POS }
    var lock: Bool {
        get { self._isLocked }
        set(lock) {
            self._isLocked = lock
            self._toggleCallback?(TileEvent.LOCKED)
        }
    }
    var perimeter: Perimeter {
        get { self._perimeter }
        set(perimeter) {
            self._perimeter = perimeter
            self._value = perimeter.sum
        }
    }
    var isMined: Bool { self._isMined }
    var isToggled: Bool { self._isToggled }
    var isLocked: Bool { self._isLocked }
    var color: Color {
        guard self._value > 0 && self._value < self._colors.count else {
            return Color.black
        }
        return self._colors[self._value - 1]
    }
    
    init(pos: Int) {
        self._POS = pos
        self._perimeter = Perimeter()
    }
    
    public func toggle() -> Bool {
        if !self._isLocked && !self._isToggled {
            self._isToggled = true
            if self._isMined {
                self._toggleCallback?(TileEvent.MINED)
                return false
            }
            self._toggleCallback?(TileEvent.TOGGLED)
            if self.value == "" {
                self.perimeter.forEach { tile in
                    if !tile.isLocked {
                        _ = tile.toggle()
                    }
                }
            }
        }
        return true
    }
    
    public func mine() -> Void {
        self._isMined = true
    }
    
    public func addToggleCallback(_ toggleCallback: @escaping (TileEvent) -> Void) -> Void {
        self._toggleCallback = toggleCallback
    }
}
