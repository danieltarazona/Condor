//
//  Core+Color.swift
//  Core
//
//  Created by Daniel Tarazona on 5/24/21.
//

import Foundation
import SwiftUI

extension Color {
    func fromHex(hex: UInt) -> Color {
        return Color(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

