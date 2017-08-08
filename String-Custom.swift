//
//  String-Custom.swift
//  Project2
//
//  Created by UserMOL on 18/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Swift // or Foundation

extension String {
    
    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
}
