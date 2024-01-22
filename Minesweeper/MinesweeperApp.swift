//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

@main
struct MinesweeperApp: App {
    
    private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(game)
        }
    }
}
