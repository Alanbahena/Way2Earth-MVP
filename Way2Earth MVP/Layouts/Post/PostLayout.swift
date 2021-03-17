//
//  PostLayout.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class PostLayout: UICollectionViewLayout {
    
    weak var delegate: PostLayoutDelegate!
    
    private var headerCache = [PostLayoutAttributes]()
    private var itemCache = [PostLayoutAttributes]()
    
    var numberOfcolumns = 2
    var cellPadding:CGFloat = 5
    
    //Total height of the content. Will be used to configure the scrollview content.
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - insets.left - insets.right
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return PostLayoutAttributes.self
    }

    
    //Layout is Calculated here.
    override func prepare() {
        super.prepare()
        
        //Layout Attributes are only calculated when cache is empty and the collection view exists.
        guard itemCache.isEmpty, headerCache.isEmpty, let collection = collectionView else { return }
        
        let columnWidth  = contentWidth / CGFloat(numberOfcolumns)
        let cellWidth = columnWidth - (cellPadding * 2)
        
        var xOffset = [CGFloat]()
        
        for colum in 0 ..< numberOfcolumns {
            xOffset.append(CGFloat(colum) * columnWidth)
        }
        
        //Layout Starts Here ...
        
        for section in 0..<collection.numberOfSections {
            //Header
            let headerImageSize = delegate.collectionView(collectionView: collection, sizeForSectionImageHeaderViewForSection: section)
            let headerAnnotationSize = delegate.collectionView(collectionView: collection, sizeForSectionAnnotationHeaderViewForSection: section)
            let headersize = headerImageSize + headerAnnotationSize
            let headerFrame = CGRect(x: 0.0, y: contentHeight, width: collection.frame.size.width, height: headersize)
            let headerAttributes = PostLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(row: 0, section: section))
            headerAttributes.frame = headerFrame
            headerAttributes.imageHeader = headerImageSize
            contentHeight = headerFrame.maxY
            headerCache.append(headerAttributes)
            
            //Cell
            var yOffset = [CGFloat] (repeating: contentHeight, count: numberOfcolumns)
            var columToplacePhoto = yOffset.firstIndex(of: yOffset.min() ?? 0) ?? 0
            
            for item in 0..<collection.numberOfItems(inSection: section){
                let indexPath = IndexPath(item: item, section: section)
                
                let photoHeight:CGFloat = delegate.collectionView(collectionView: collection, heightForImageAtIndexPath: indexPath, withWidth: cellWidth)
                let annotationHeight:CGFloat = delegate.collectionView(collectionView: collection, heightForAnnotationAtIndexPath: indexPath, withWidth: cellWidth)
                let cellHeight = cellPadding + photoHeight + annotationHeight + cellPadding
                
                let frame = CGRect(x: xOffset[columToplacePhoto], y: yOffset[columToplacePhoto], width: columnWidth, height: cellHeight)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = PostLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = photoHeight
                attributes.frame = insetFrame
                
                itemCache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[columToplacePhoto] = yOffset[columToplacePhoto] + cellHeight
                columToplacePhoto = columToplacePhoto < (numberOfcolumns - 1) ? (columToplacePhoto + 1) : 0
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        
        var layoutAttributes: [PostLayoutAttributes] = []
        
        for attributes in itemCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        for attributes in headerCache {
            if attributes.frame.intersects(rect){
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        return headerCache[indexPath.section]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
      return itemCache[indexPath.item]
    }
    
    override func invalidateLayout() {
        itemCache.removeAll()
        headerCache.removeAll()
        contentHeight = 0
        super.invalidateLayout()
    }
    
}
