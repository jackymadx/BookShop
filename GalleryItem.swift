//
//  GalleryItem.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation

class GalleryItem {
    
    var itemImage: String
    
    init(dataDictionary:Dictionary<String,String>) {
        itemImage = dataDictionary["itemImage"]!
    }
    
    class func newGalleryItem(_ dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }
}
