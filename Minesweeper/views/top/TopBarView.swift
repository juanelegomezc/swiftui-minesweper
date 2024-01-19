//
//  TopBarView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI
import Combine

struct TopBarView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(Game.self) var game
    
    @State private var isActive = true
    
    var body: some View {
        HStack {
            Spacer()
            LCDDisplayView(length: 3, value: self.game.field.remainingMines)
            Spacer()
            FaceView()
            Spacer()
            LCDDisplayView(length: 3, value: self.game.seconds)
            Spacer()
        }
        .frame(maxHeight: 30)
        .onChange(of: scenePhase, initial: false) { newPhase, arg  in
            isActive = newPhase == .active
        }
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
            .environment(Game())
    }
}
