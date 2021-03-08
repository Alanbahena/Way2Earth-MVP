//
//  SearchCollectionViewCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/5/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let searchIdentifier = "SearchCell"

class SearchCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var categorie: Categorie! {
        didSet { configure() }
    }
    
    private var imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 13
        iv.backgroundColor = .red
        iv.alpha = 0.5
        return iv
    }()
    
    private var label: UILabel = {
       let label = UILabel()
        label.textColor = .init(white: 1, alpha: 0.9)
        label.font = .merriWeatherBold(size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.addCharacterSpacing(kernValue: 0.7)
        return label
    }()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidth(contentView.frame.width)
        label.centerY(inView: contentView)
        label.centerX(inView: contentView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        imageView.image = categorie.image
        label.text = categorie.categoryText
    }
}
