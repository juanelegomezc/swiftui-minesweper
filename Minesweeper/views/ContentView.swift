//
//  ContentView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(
        Game.self
    ) private var game
    @Environment(
        \.colorScheme
    ) private var colorScheme
    
    private var _color: String {
        colorScheme == .dark ? DARK_MODE_BACKGROUND_COLOR : LIGHT_MODE_BACKGROUND_COLOR
    }
    
    var body: some View {
        Color(
            fromHex: self._color
        )
        .ignoresSafeArea()
        .overlay(
            VStack {
                TopBarView()
                ScrollView {
                    VStack {
                        FieldView()
                    }
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                Game(
                    level: Level.BEGINNER
                )
            )
    }
}
