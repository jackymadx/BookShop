//
//  UIImageView-Custom.swift
//  Project2
//
//  Created by UserMOL on 13/07/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.75
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    
    }
}
