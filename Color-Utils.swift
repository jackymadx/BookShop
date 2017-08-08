//
//  ColorUtils.swift
//  Project2
//
//  Created by UserMOL on 20/07/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit

struct ColorUtils {
    static func hexToUIColor (hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgbValue: UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgbValue)
        let red = (CGFloat((rgbValue & 0xFF0000) >> 16)) / 255.0
        let green = (CGFloat((rgbValue & 0xFF00) >> 8)) / 255.0
        let blue = CGFloat((rgbValue & 0xFF)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
