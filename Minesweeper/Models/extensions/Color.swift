//
//  Color.swift
//  Minesweeper
//
//  Created by Juan Gómez on 30/08/23.
//

import Foundation
import SwiftUI

extension Color {
    
    init(fromHex: String) {
        let defaultColor: Color = .white
        var cleanedHex = fromHex
        if cleanedHex.starts(with: "#") {
            cleanedHex = String(fromHex[fromHex.index(fromHex.startIndex , offsetBy: 1)..<fromHex.endIndex])
        }
        guard cleanedHex.count == 3 || cleanedHex.count == 6 else {
            self.init(defaultColor)
            return
        }
        var hex: [UInt32] = []
        let by = cleanedHex.count == 3 ? 1 : 2
        for i in stride(from: 0, through: by * 2, by: by) {
            var hexPair = String(cleanedHex[cleanedHex.index(cleanedHex.startIndex , offsetBy: i)..<cleanedHex.index(cleanedHex.startIndex , offsetBy: i + by)])
            if hexPair.count == 1 {
                hexPair += hexPair
            }
            hex.append(UInt32(hexPair, radix: 16) ?? 0)
        }
        
        self.init(CGColor(red: CGFloat(hex[0])/255, green: CGFloat(hex[1])/255, blue: CGFloat(hex[2])/255, alpha: 1))
    }
    
}
