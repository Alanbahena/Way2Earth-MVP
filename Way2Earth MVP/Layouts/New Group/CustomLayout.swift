//
//  PinterestLayout.swift
//  Test6
//
//  Created by Alan Bahena on 2/13/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit



class FeedLayout: UICollectionViewLayout {
    
    weak var delegate: FeedLayoutDelegate!
    
    var cache = [CustomLayoutAttributes]()
    
    var numberOfcolumns = 2
    
    var cellPadding:CGFloat = 5
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - insets.left - insets.right
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collection = collectionView else { return }
        let columnWidth  = contentWidth / CGFloat(numberOfcolumns)
        let cellWidth = columnWidth - (cellPadding * 2)
        
        var xOffset = [CGFloat]()
      
        for colum in 0 ..< numberOfcolumns {
            xOffset.append(CGFloat(colum) * columnWidth)
        }
        
        var columToplacePhoto = 0
        var yOffset = [CGFloat] (repeating: 0, count: numberOfcolumns)
        
        for item in 0..<collection.numberOfItems(inSection: 0){
            
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight:CGFloat = delegate.collectionView(collectionView: collection, heightForImageAtIndexPath: indexPath, withWidth: cellWidth)
            let annotationHeight:CGFloat = delegate.collectionView(collectionView: collection, heightForAnnotationAtIndexPath: indexPath, withWidth: cellWidth)
            let cellHeight = cellPadding + photoHeight + annotationHeight + cellPadding
            
            let frame = CGRect(x: xOffset[columToplacePhoto], y: yOffset[columToplacePhoto], width: columnWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = CustomLayoutAttributes(forCellWith: indexPath)
            attributes.imageHeight = photoHeight
            attributes.frame = insetFrame
            
            self.cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[columToplacePhoto] = yOffset[columToplacePhoto] + cellHeight
            columToplacePhoto = columToplacePhoto < (numberOfcolumns - 1) ? (columToplacePhoto + 1) : 0
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}
