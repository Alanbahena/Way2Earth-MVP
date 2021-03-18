//
//  PostHeader.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let postHeaderCellIdentifier = "PostHeader"

class PostHeaderCell: UICollectionReusableView {
    
    static let postImagePadding: CGFloat = 10
    static let buttonsPadding: CGFloat = 48
    static let titlePadding: CGFloat = 15
    static let timePadding: CGFloat = 5
    static let descriptionPadding: CGFloat = 10
    static let userPostLabelPadding: CGFloat = 50
    
    //MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    private var _headerView: UIView?
    private var headerView: UIView {
        get {
            if let roundedCornersView = _headerView {
                return roundedCornersView
            }
            let headerView = UIView(frame: bounds)
            _headerView = headerView
            addSubview(headerView)
            headerView.addConstraintsAlignedToSuperview()
            return headerView
        }
    }
    
    private var _postImageView: UIImageView?
    private var postImageView: UIImageView {
        get {
            if let postImageView = _postImageView {
                return postImageView
            }
            let postImageView = UIImageView(frame: headerView.bounds)
            _postImageView = postImageView
            headerView.addSubview(postImageView)
            self.addConstraintsForPostImageView()
            
            postImageView.contentMode = .scaleAspectFit
            postImageView.layer.masksToBounds = true
            postImageView.layer.cornerRadius = 13
            
            return postImageView
        }
    }
    
    private var imageViewHeightLayoutConstraint: NSLayoutConstraint?
    private var imageHeight: CGFloat!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PostLayoutAttributes {
            imageHeight = attributes.imageHeader
            if let imageViewHeightLayoutConstraint = self.imageViewHeightLayoutConstraint {
                imageViewHeightLayoutConstraint.constant = attributes.imageHeader
            }
        }
    }
    
    private var _commentsLabel: UILabel?
    private var commentsLabel: UILabel {
        get {
            if let commentsLabel =  _commentsLabel {
                return commentsLabel
            }
            let commentsLabel = UILabel()
            _commentsLabel = commentsLabel
            headerView.addSubview(commentsLabel)
            self.addComstraintForCommentsLabel()
            
            commentsLabel.font = UIFont.RobotoRegular(size: 15)
            commentsLabel.numberOfLines = 1
            commentsLabel.textColor = .white
            return commentsLabel
        }
    }
    
    private var _commentsIcon: UIButton?
    private var commentsIcon: UIButton {
        get {
            if let commentsIcon = _commentsIcon {
                return commentsIcon
            }
            let commentsIcon = UIButton(type: .system)
            _commentsIcon = commentsIcon
            headerView.addSubview(commentsIcon)
            self.addConstraintForButtonIcon()
            
            commentsIcon.tintColor = .white
            commentsIcon.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
                    return commentsIcon
        }
    }
    
    private var _likesLabel: UILabel?
    private var likesLabel: UILabel {
        get {
            if let likesLabel = _likesLabel {
                return likesLabel
            }
            
            let likesLabel = UILabel()
            _likesLabel = likesLabel
            headerView.addSubview(likesLabel)
            self.addConstraintForLikesLabel()
            
            likesLabel.font = UIFont.RobotoRegular(size: 15)
            likesLabel.numberOfLines = 1
            likesLabel.textColor = .white
            return likesLabel
        }
    }
    
    private var _likesIcon: UIButton?
    private var likesIcon: UIButton {
        get {
            if let likesIcon = _likesIcon {
                return likesIcon
            }
            let likesIcon = UIButton(type: .system)
            _likesIcon = likesIcon
            headerView.addSubview(likesIcon)
            self.addCosntraintForLikesIcon()
            
            likesIcon.tintColor = .white
            likesIcon.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
            return likesIcon
        }
    }
    
    private var _titleLabel: UILabel?
    private var titleLabel: UILabel {
        get {
            if let titleLabel = _titleLabel {
                return titleLabel
            }
            let titleLabel = UILabel()
            _titleLabel = titleLabel
            headerView.addSubview(titleLabel)
            self.addCosntraintForTitleLabel()
            
            titleLabel.font = UIFont.merriWeatherBold(size: 17)
            titleLabel.numberOfLines = 0
            titleLabel.textColor = .white
            return titleLabel
        }
    }
    
    private var _postTimeLabel: UILabel?
    private var postTimeLabel: UILabel {
        get {
            if let postTimeLabel = _postTimeLabel {
                return postTimeLabel
            }
            let postTimeLabel = UILabel()
            _postTimeLabel = postTimeLabel
            headerView.addSubview(postTimeLabel)
            self.addConstraintForPostTimeLabel()
            
            postTimeLabel.font = UIFont.openSansRegular(size: 12)
            postTimeLabel.numberOfLines = 0
            postTimeLabel.textColor = .white
            return postTimeLabel
        }
    }
    
    private var _descriptionLabel: UILabel?
    private var descriptionLabel: UILabel {
        get {
            if let descriptionLabel = _descriptionLabel {
                return descriptionLabel
            }
            let descriptionLabel = UILabel()
            _descriptionLabel = descriptionLabel
            headerView.addSubview(descriptionLabel)
            self.addCosntraintForDescriptionLabel()
            
            descriptionLabel.font = UIFont.openSansRegular(size: 13)
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .white
            return descriptionLabel
        }
    }
    
    private var _userPostsLabel: UILabel?
    private var userPostsLabel: UILabel {
        get {
            if let userPostsLabel = _userPostsLabel {
                return  userPostsLabel
            }
            
            let userPostsLabel = UILabel()
            _userPostsLabel = userPostsLabel
            headerView.addSubview(userPostsLabel)
            self.addConstraintForUserPostsLabel()
            
            userPostsLabel.font = UIFont.robotoBold(size: 16)
            userPostsLabel.numberOfLines = 1
            userPostsLabel.textColor = .white
            userPostsLabel.textAlignment = .center
            return userPostsLabel
        }
    }
    
    
    
    
    
    //MARK: - Helpers
    
    @objc func didTapLike() {
        print("DEBUG: Likes Tapped ..")
    }
    
    @objc func didTapComments() {
        print("DEBUG: Comments Tapped ..")
    }
}

    //MARK: - Actions

extension PostHeaderCell {
    
    
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        //Post
        postImageView.sd_setImage(with: viewModel.imageUrl)
        commentsLabel.text = "25"
        commentsIcon.setImage(#imageLiteral(resourceName: "CommentsIcon"), for: .normal)
        likesLabel.text = "512"
        likesIcon.setImage(#imageLiteral(resourceName: "likeunselected"), for: .normal)
        
        //Description
        titleLabel.text = viewModel.title
        postTimeLabel.text = "20 hours ago"
        descriptionLabel.text = viewModel.description
        
        //UserInfo
        userPostsLabel.text = "More of \(viewModel.userFullName)"
    }
    
    func addConstraintsForPostImageView() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, right: headerView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        let imageViewHeightLayoutConstraint =
            NSLayoutConstraint(
                item: postImageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: imageHeight
        )
        postImageView.addConstraint(imageViewHeightLayoutConstraint)
        self.imageViewHeightLayoutConstraint = imageViewHeightLayoutConstraint
    }
    
    func addComstraintForCommentsLabel() {
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.anchor(top: postImageView.bottomAnchor, right: postImageView.rightAnchor, paddingTop: 25)
    }
    
    func addConstraintForButtonIcon() {
        commentsIcon.translatesAutoresizingMaskIntoConstraints = false
        commentsIcon.anchor(top: postImageView.bottomAnchor, right: commentsLabel.leftAnchor, paddingTop: 25, paddingRight: 5)
                commentsIcon.setDimensions(height: 28, width: 28)
    }
    
    func addConstraintForLikesLabel() {
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.anchor(top: postImageView.bottomAnchor, right: commentsIcon.leftAnchor, paddingTop: 25, paddingRight: 15)
    }
    
    func addCosntraintForLikesIcon() {
        likesIcon.translatesAutoresizingMaskIntoConstraints = false
        likesIcon.anchor(top: postImageView.bottomAnchor, right: likesLabel.leftAnchor, paddingTop: 20, paddingRight: 5)
                likesIcon.setDimensions(height: 28, width: 28)
    }
    
    func addCosntraintForTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: likesIcon.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
    }
    
    func addConstraintForPostTimeLabel() {
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: 5)
    }
    
    func addCosntraintForDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                descriptionLabel.anchor(top: postTimeLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingTop: 10)
    }
    
    func addConstraintForUserPostsLabel() {
        userPostsLabel.translatesAutoresizingMaskIntoConstraints = false
        userPostsLabel.anchor(top: descriptionLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingTop: 30)
    }
}
