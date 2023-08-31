//
//  LCDDigitView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct LCDDigitView: View {
    var value: Int
    var body: some View {
        Image("d\(value)")
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
    }
}

struct LCDDigitView_Previews: PreviewProvider {
    static var previews: some View {
        LCDDigitView(value: 0)
        LCDDigitView(value: 2)
    }
}
