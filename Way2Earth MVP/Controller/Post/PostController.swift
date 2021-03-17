//
//  PostController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

protocol PostLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, sizeForSectionImageHeaderViewForSection section: Int) -> CGFloat
    func collectionView(collectionView: UICollectionView, sizeForSectionAnnotationHeaderViewForSection section: Int) -> CGFloat
}

class PostController: UICollectionViewController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setTitleViewNavigationBar()
        
    }
    
    //MARK: - Helpers
    
    func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.spaceColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        collectionView.register(PostHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: postHeaderCellIdentifier)
        
        if let layout = collectionView.collectionViewLayout as? PostLayout {
            layout.delegate = self
        }
    }
    
    func setTitleViewNavigationBar() {
        let title = "Alan Bahena"
        let image = #imageLiteral(resourceName: "profileImage")
        setTitle(title, andImage: image)
    }
    
    
    
    
    
    //MARK: - UICOllectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: postHeaderCellIdentifier, for: indexPath) as! PostHeaderCell
        return header
    }
}

    //MARK: - ProfileLayoutDelegate

extension PostController: PostLayoutDelegate {
    
    //Item
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return 250
    }
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return 50
    }
    
    //Header
    func collectionView(collectionView: UICollectionView, sizeForSectionImageHeaderViewForSection section: Int) -> CGFloat {
        return 300
    }
    
    func collectionView(collectionView: UICollectionView, sizeForSectionAnnotationHeaderViewForSection section: Int) -> CGFloat {
        return 700
        
    }
}

//MARK: - URLSizeOfImage

extension PostController {

func sizeOfImageAt(url: URL) -> CGSize? {
        // with CGImageSource we avoid loading the whole image into memory
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }

        let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
            return nil
        }

        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
            let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return nil
        }
    }
}
