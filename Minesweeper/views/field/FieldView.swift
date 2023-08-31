//
//  FieldView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct FieldView: View {
    @StateObject var field: Field
    @State private var hover: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<self.field.rows, id: \.self) { y in
                HStack(spacing: 0) {
                    ForEach(0..<self.field.cols, id: \.self) { x in
                        TileView(
                            tile: self._getTile(x: x, y: y, cols: field.cols)
                        )
                            .frame(
                                minWidth: self.minWidth,
                                minHeight: self.minHeight
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
                .frame(minHeight: 31)
            }
        }
        .border(Color(fromHex: "#444"))
    }
    
    private var settings: Settings {
        get { Settings.shared }
    }
    
    private var minWidth: CGFloat {
        get { CGFloat(self.settings.tile.width) }
    }
    
    private var minHeight: CGFloat {
        get { CGFloat(self.settings.tile.width) }
    }
    
    private func _getTile(x: Int, y: Int, cols: Int) -> Tile {
        let pos = y * cols + x
        return self.field[pos]!
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView(field: Field(level: Level.BEGINNER))
    }
}
