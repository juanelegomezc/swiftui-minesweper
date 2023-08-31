//
//  LCDDisplay.swift
//  Minesweeper
//
//  Created by Juan Gómez on 27/08/23.
//

import SwiftUI

struct LCDDisplayView: View {
    var length: Int
    var value: Int
    
    var body: some View {
        HStack {
            ForEach((0...(length - 1)), id: \.self) {index in
                LCDDigitView(value: self.getDigitValue(pos: index))
            }
        }
    }
    
    func getDigitValue(pos: Int) -> Int {
        let strValue = "\(self.value)"
        let pad = self.length - strValue.count
        if self.length - pos > strValue.count {
            return 0
        }
        return strValue[strValue.index(strValue.startIndex, offsetBy: pos - pad)].wholeNumberValue ?? 0
    }
}

struct LCDDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        LCDDisplayView(length: 3, value: 879)
    }
}
