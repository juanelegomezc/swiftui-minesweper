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
    
    var digits: [LCDDigitView] {
        var digits: [LCDDigitView] = []
        (0..<self.length).forEach { index in
            digits.append(LCDDigitView(pos: self.length - index - 1, value: self.getDigitValue(pos: index)))
        };
        return digits
    }
    
    var body: some View {
        HStack {
            ForEach(digits, id: \.hashValue) { $0 }
        }
    }
    
    func getDigitValue(pos: Int) -> Int {
        let strValue = "\(self.value)"
        let pad = self.length - strValue.count
        if self.length - pos > strValue.count {
            return 0
        }
        let startIndex = strValue.startIndex
        return strValue[strValue.index(startIndex, offsetBy: pos - pad)].wholeNumberValue ?? 0
    }
}

struct LCDDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        LCDDisplayView(length: 3, value: 321)
    }
}
