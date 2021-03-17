//
//  PostHeader.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let postHeaderCellIdentifier = "PostHeader"

class PostHeaderCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.backgroundColor = .lightGray
        postImage.layer.masksToBounds = true
        postImage.layer.cornerRadius = 25
        postImage.contentMode = .scaleAspectFill
        postImage.image = #imageLiteral(resourceName: "photo1")
        return postImage 
    }()
    
    private var commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.RobotoRegular(size: 15)
        label.numberOfLines = 1
        label.text = "25"
        label.textColor = .white
        return label
    }()
    
    private lazy var commentsIcon: UIButton = {
        let icon = UIButton(type: .system)
        icon.setImage(#imageLiteral(resourceName: "CommentsIcon"), for: .normal)
        icon.tintColor = .white
        icon.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        return icon
    }()
    
    private var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.RobotoRegular(size: 15)
        label.numberOfLines = 1
        label.text = "512"
        label.textColor = .white
        return label
    }()
    
    private lazy var likesIcon: UIButton = {
        let icon = UIButton(type: .system)
        icon.setImage(#imageLiteral(resourceName: "likeunselected"), for: .normal)
        icon.tintColor = .white
        icon.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return icon
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.merriWeatherBold(size: 17)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "The secrets I found in the Mayan Culture"
        return label
    }()
    
    private var postTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.openSansRegular(size: 12)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "20 hours ago"
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.openSansRegular(size: 13)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "While I Was traveling through mayan ancient territories , I discover something more than ancient pyramids. More than ancient rocks standing in the middle of a jungle. I discovered a culture that might knew the secrets of the universe. The secrets of life. We normally look back to the ancient cultures and think that they were the pioneers in human evolution. But I might think that they knew everything. They understood the Universe, science and the laws of life. There could be a possibility that we can create a better future if we learn from the ancient cultures."
        return label
    }()
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //PostImage
        addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.anchor(top: topAnchor, left: leftAnchor, right: contentView.rightAnchor, paddingTop: 10 ,paddingLeft: 10, paddingRight: 10)
        postImage.setHeight(500)
        
        //CommentsLabel
        addSubview(commentsLabel)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.anchor(top: postImage.bottomAnchor, right: postImage.rightAnchor, paddingTop: 30)
        
        //CommentsIcon
        addSubview(commentsIcon)
        commentsIcon.translatesAutoresizingMaskIntoConstraints = false
        commentsIcon.anchor(top: postImage.bottomAnchor, right: commentsLabel.leftAnchor, paddingTop: 30, paddingRight: 5)
        commentsIcon.setDimensions(height: 28, width: 28)
        
        //LikesLabel
        addSubview(likesLabel)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.anchor(top: postImage.bottomAnchor, right: commentsIcon.leftAnchor, paddingTop: 30, paddingRight: 15)
        
        //LikesIcon
        addSubview(likesIcon)
        likesIcon.translatesAutoresizingMaskIntoConstraints = false
        likesIcon.anchor(top: postImage.bottomAnchor, right: likesLabel.leftAnchor, paddingTop: 25, paddingRight: 5)
        likesIcon.setDimensions(height: 28, width: 28)
        
        //titleLabel
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: likesIcon.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        
        //PostTimeLabel
        addSubview(postTimeLabel)
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: 5)
        
        //Description Label
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.anchor(top: postTimeLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingTop: 10)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    @objc func didTapLike() {
        print("DEBUG: Likes Tapped ..")
    }
    
    @objc func didTapComments() {
        print("DEBUG: Comments Tapped ..")
    }
}
