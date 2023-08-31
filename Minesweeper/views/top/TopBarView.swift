//
//  TopBarView.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        HStack {
            Spacer()
            LCDDisplayView(length: 3, value: 0)
            Spacer()
            FaceView()
            Spacer()
            LCDDisplayView(length: 3, value: 0)
            Spacer()
        }
        .frame(maxHeight: 30)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
