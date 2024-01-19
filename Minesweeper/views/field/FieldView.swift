//
//  FieldView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct FieldView: View {
    
    @Environment(Game.self) private var game
    
    #if os(macOS)
    @State private var hover: Bool = false
    #endif
    
    var body: some View {
        let minWidth = CGFloat(self.game.settings.tile.width)
        let minHeight = CGFloat(self.game.settings.tile.height)
        VStack(spacing: 0) {
            ForEach(self._getRows(), id: \.hashValue) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.hashValue) { tile in
                        tile
                            .frame(
                                minWidth: minWidth,
                                minHeight: minHeight
                            )
                            #if os(macOS)
                            .onHover(perform: {hovering in
                                self.hover = hovering
                                if (hover) {
                                    NSCursor.pointingHand.push()
                                } else {
                                    NSCursor.pop()
                                }
                            })
                            #endif
                    }
                }
            }
        }
        .border(Color(fromHex: "#444"))
    }
    
    private func _getRows() -> [[TileView]] {
        var rows: [[TileView]] = []
        (0..<self.game.field.rows).forEach { y in
            var tiles: [TileView] = []
            (0..<self.game.field.cols).forEach { x in
                tiles.append(self._getTileViewAt(x, y))
            }
            rows.append(tiles)
        }
        return rows
    }
    
    private func _getTileViewAt(_ x: Int, _ y: Int) -> TileView {
        return TileView(
            pos: self._getPos(x: x, y: y, cols: self.game.field.cols)
        )
    }
    
    private func _getPos(x: Int, y: Int, cols: Int) -> Int {
        return y * cols + x
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView()
            .environment(Game())
    }
}
