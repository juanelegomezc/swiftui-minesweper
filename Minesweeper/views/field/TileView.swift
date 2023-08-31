//
//  TileView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct TileView: View {
    @ObservedObject var tile: Tile
    
    var body: some View {
        Group {
            if !tile.isToggled {
                AnyView(
                    Image("tile")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 31, height: 31)
                        .onTapGesture {
                            if !tile.toggle() {
                                print("Bomb")
                            }
                        }
                )
            } else {
                AnyView(
                    ZStack {
                        Rectangle()
                            .fill(Color(fromHex: "#bfbfbf"))
                            .border(Color(fromHex: "#444"))
                            .frame(width: 31, height: 31)
                        Text(tile.value)
                            .fontWeight(.bold)
                            .foregroundColor(tile.color)
                    }
                )
            }
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(pos: 0))
    }
}
