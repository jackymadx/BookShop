//
//  TextField-Helper.swift
//  Project2
//
//  Created by UserMOL on 18/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addBorderBottom(_ height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
