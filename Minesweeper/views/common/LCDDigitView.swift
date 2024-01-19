//
//  LCDDigitView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct LCDDigitView: View, Hashable {
    var pos: Int
    var value: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pos)
    }
    
    var body: some View {
        Image("d\(value)")
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
    }
}

struct LCDDigitView_Previews: PreviewProvider {
    static var previews: some View {
        LCDDigitView(pos: 0, value: 0)
        LCDDigitView(pos: 0, value: 2)
    }
}
