//
//  ContentView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var field: Field = Field(level: Level.EXPERT)
    var body: some View {
        Color(fromHex: colorScheme == .dark ? "#333" : "#bfbfbf")
            .ignoresSafeArea()
            .overlay(
                VStack {
                    TopBarView()
                    Spacer()
                    ScrollView([.horizontal, .vertical] ,showsIndicators: false) {
                        FieldView(field: field)
                    }
                    Spacer()
                }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
