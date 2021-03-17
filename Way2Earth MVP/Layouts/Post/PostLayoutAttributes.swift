//
//  PostLayoutAttributes.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class PostLayoutAttributes: UICollectionViewLayoutAttributes {

    var imageHeight: CGFloat = 0
    var imageHeader: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PostLayoutAttributes
        copy.imageHeight = imageHeight
        copy.imageHeader = imageHeader
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PostLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
            if attributes.imageHeader == imageHeader {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}
