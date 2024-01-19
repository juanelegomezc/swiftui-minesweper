//
//  FaceView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct FaceView: View {
    
    @Environment(Game.self) private var game
    
    var body: some View {
        ZStack {
            Image("tile")
                .resizable()
                .frame(width: 45, height: 35)
            Button(self._face) {
                self.game.newGame()
            }
        }
    }
    
    private var _face: String {
        get {
            if self.game.finished {
                if self.game.won {
                    return "😎"
                } else {
                    return "😣"
                }
            }
            return "🙂"
        }
    }
}

struct FaceView_Previews: PreviewProvider {
    static var previews: some View {
        FaceView()
            .environment(Game())
    }
}
