//
//  GalleryItemCollectionViewCell.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var amountButton:UIButton!
    
    func setGalleryItem(_ item:GalleryItem) {
        itemImageView.image = UIImage(named: item.itemImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    
}
