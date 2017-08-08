//
//  MarkerInfoView.swift
//  Project2
//
//  Created by UserMOL on 02/08/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit

class MarkerInfoView: UIView {
    
    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Bundle.main.loadNibNamed("MarkerInfoView", owner: self, options: nil)
         // adding the top level view to the view hierarchy
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing:"MarkerInfoView"), owner: nil, options: nil)![0] as! T
    }
    
    func instanceFromNib() -> UIView {
        return UINib(nibName: "MarkerInfoView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
