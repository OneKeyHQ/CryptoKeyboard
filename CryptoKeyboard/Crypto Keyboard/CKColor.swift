//
//  CKColor.swift
//  Crypto Keyboard
//
//  Created by liuzhijie on 2021/2/9.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let text0 = Color.black
    static let text1 = Color(hex: 0x3c3c43, alpha: 0.6)
    static let text2 = Color(hex: 0x787980)
    static let text3 = Color(hex: 0x1a1a1a)
    static let text4 = Color(hex: 0x3c3c43, alpha: 0.48)

    static let normal = Color(hex: 0x1a1a1a)
    static let privateKey = Color(hex: 0xFF3B30)
    static let address = Color(hex: 0xF6C914)

    static let green1 = Color(hex: 0x1FBF2F)
}
