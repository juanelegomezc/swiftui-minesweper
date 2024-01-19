//
//  Game.swift
//  Minesweeper
//
//  Created by Juan Gómez on 14/01/24.
//

import Combine
import Foundation

/// Represents an active game
@Observable
class Game {
    
    private let _SETTINGS: Settings
    
    private var _currentLevel: Level
    private var _field: Field?
    private var _seconds: Int
    private var _timer: Timer?
    private var _finished: Bool
    private var _won: Bool
    
    var field: Field { self._field! }
    var settings: Settings { self._SETTINGS }
    var seconds: Int { self._seconds }
    var finished: Bool { self._finished }
    var won: Bool { self._won }
    
    /// Creates a new Game for the corresponding ``Level``
    init(level: Level = Level.BEGINNER) {
        let settings = Settings()
        self._SETTINGS = settings
        self._currentLevel = level
        self._seconds = 0
        self._finished = false
        self._won = false
        self.newGame(level: level)
    }
    
    private func _onGameFinish(won: Bool) -> Void {
        self._finished = true
        self._won = won
        self._timer?.invalidate()
    }
    
    func newGame(level: Level) -> Void {
        self._timer?.invalidate()
        self._seconds = 0
        self._finished = false
        self._won = false
        self._timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self._seconds += 1
        }
        self._field = Field(level: level, settings: self._SETTINGS, onGameFinish: self._onGameFinish)
    }
    
    func newGame() -> Void {
        self.newGame(level: self._currentLevel)
    }
}
