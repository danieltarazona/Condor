//
//  AppDevices.swift
//  Core
//
//  Created by Daniel Tarazona on 3/05/21.
//

import UIKit

struct AppDevices {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width

    static var iPhone5SE: Bool {
        return height <= 568
    }

    static var iPhone678SE2: Bool {
        return height > 568 && height <= 667
    }

    static var iPhone678Plus: Bool {
        return height > 667 && height <= 736
    }

    static var iPhoneX12: Bool {
        return height > 736
    }

    static func logHeight() {
        print("DEVICE HEIGHT: \(height)")
    }

    static func logWidth() {
        print("DEVICE WIDTH: \(width)")
    }

    static func log() {
        print("DEVICE HEIGHT: \(height)")
        print("DEVICE WIDTH: \(width)")
    }
}
