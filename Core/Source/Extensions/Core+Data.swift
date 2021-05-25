//
//  Core+Data.swift
//  Core
//
//  Created by Administrator on 5/23/21.
//

import Foundation
import UIKit

extension Data {
    var toUIImage: UIImage {
        if let uiImage = UIImage(data: self) {
            return uiImage
        }
        return UIImage(named: "noImage") ?? UIImage()
    }
}
