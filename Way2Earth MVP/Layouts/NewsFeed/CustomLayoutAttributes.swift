//
//  PinterestLayoutAttributes.swift
//  LayoutTest3
//
//  Created by Alan Bahena on 2/11/21.
//  Copyright © 2021 Alan Bahena . All rights reserved.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit


/**
 CollectionViewLayoutAttributes.
 */

class CustomLayoutAttributes: UICollectionViewLayoutAttributes {
    /**
     Image height to be set to contstraint in collection view cell.
     */
    var imageHeight: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CustomLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CustomLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}
