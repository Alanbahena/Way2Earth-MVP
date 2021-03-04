//
//  profileLayoutAttributes.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/3/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit


/**
 CollectionViewLayoutAttributes.
 */

class ProfileLayoutAttributes: UICollectionViewLayoutAttributes {
    /**
     Image height to be set to contstraint in collection view cell.
     */
    var imageHeight: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ProfileLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? ProfileLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}
