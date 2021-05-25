//
//  Core+String.swift
//  Core
//
//  Created by Daniel Tarazona on 5/23/21.
//

import Foundation
import SwiftUI

extension String {
    var isURL: Bool {
        guard !self.isEmpty else { return false }
        
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
   }
}
