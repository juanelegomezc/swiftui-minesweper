//
//  TileView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct TileView: View, Hashable {
    
    @Environment(Game.self) private var game
    
    let pos: Int
    
    var body: some View {
        let tile = self.game.field[self.pos]!
        if !tile.isToggled {
            ZStack {
                Image("tile")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 31, height: 31)
                    .onTapGesture {
                        if !self.game.finished {
                            let _ = tile.toggle()
                        }
                    }
                    .onLongPressGesture {
                        if !self.game.finished && !tile.isToggled {
                            tile.lock = !tile.lock
                        }
                    }
                if tile.isLocked {
                    Text("🚩")
                }
            }
        } else {
            ZStack {
                Rectangle()
                    .fill(Color(fromHex: "#bfbfbf"))
                    .border(Color(fromHex: "#444"))
                    .frame(width: 31, height: 31)
                Text(tile.value)
                    .fontWeight(.bold)
                    .foregroundColor(tile.color)
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.pos)
    }
    
    static func == (lhs: TileView, rhs: TileView) -> Bool {
        return lhs.pos == rhs.pos
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(pos: 0)
            .environment(Game())
    }
}
