//
//  Tile.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import Foundation
import SwiftUI

class Tile: ObservableObject {
    let pos: Int
    private var _isMined: Bool = false
    private var _value: Int = -1
    private var _isLocked: Bool = false
    private var _perimeter: Perimeter
    private var _colors: [Color] = [
        Color(fromHex: "#00f"), // Blue
        Color(fromHex: "#008000"), //Green
        Color(fromHex: "#f00"), // Red
        Color(fromHex: "#800080"), // Purple
        Color(fromHex: "#800000"), // Maroon
        Color(fromHex: "#40e0d0"), // turquoise
        Color(fromHex: "#000"), // Black
        Color(fromHex: "#808080") // Gray
    ]
    
    @Published private var _isToggled: Bool = false
    
    var value: String {
        get {
            var value = ""
            if self._isMined {
                value = "💣"
            } else if (self._value > 0) {
                value = "\(self._value)"
            }
            return value
        }
    }
    
    var perimeter: Perimeter {
        get { self._perimeter }
        set(perimeter) {
            self._perimeter = perimeter
            self._value = perimeter.sum
        }
    }
    
    var isMined: Bool {
        get { self._isMined }
    }
    
    var isToggled: Bool {
        get { self._isToggled }
    }
    
    var color: Color {
        get {
            guard self._value > 0 && self._value < self._colors.count else {
                return Color.black
            }
            return self._colors[self._value - 1]
        }
    }
    
    init(pos: Int) {
        self.pos = pos
        self._perimeter = Perimeter()
    }
    
    public func toggle() -> Bool {
        if !self._isToggled {
            if self._isMined {
                return false
            }
            self._isToggled = true
            if self.value == "" {
                self.perimeter.forEach { tile in
                    _ = tile.toggle()
                }
            }
        }
        return true
    }
    
    public func mine() -> Void {
        self._isMined = true
    }
}
