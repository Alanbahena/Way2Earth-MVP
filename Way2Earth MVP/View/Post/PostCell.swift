//
//  PostCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let postCellIdentifier = "PostCell"

class PostCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let titleTextWidth: CGFloat = 35
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    static let annotationPadding: CGFloat = 11
    
    private var _cellView: UIView?
    private var cellView: UIView {
        get {
            if let roundedCornersView = _cellView {
                return roundedCornersView
            }
            let cellView = UIView(frame: bounds)
            _cellView = cellView
            contentView.addSubview(cellView)
            cellView.addConstraintsAlignedToSuperview()
            return cellView
        }
    }
    
    private var _imageView: UIImageView?
    private var imageView: UIImageView {
        get {
            if let imageView = _imageView {
                return imageView
            }
            let imageView = UIImageView(frame: cellView.bounds)
            _imageView = imageView
            cellView.addSubview(imageView)
            self.addConstraintsForImageView()
            
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 13
            
            return imageView
        }
    }
    
    private var imageViewHeightLayoutConstraint: NSLayoutConstraint?
    private var imageHeight: CGFloat!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PostLayoutAttributes {
            imageHeight = attributes.imageHeight
            if let imageViewHeightLayoutConstraint = self.imageViewHeightLayoutConstraint {
                imageViewHeightLayoutConstraint.constant = attributes.imageHeight
            }
        }
    }
    
    private var _titleTextLabel: UILabel?
    private var titleTextLabel: UILabel {
        get {
            if let titleTextLabel = _titleTextLabel {
                return titleTextLabel
            }
            let titleTextLabel = UILabel()
            _titleTextLabel = titleTextLabel
            cellView.addSubview(titleTextLabel)
            self.addConstraintForTitleTextLabel()
            
            titleTextLabel.font = UIFont.merriWeatherBold(size: 10)
            titleTextLabel.sizeToFit()
            titleTextLabel.numberOfLines = 2
            titleTextLabel.textColor = .white
            
            return titleTextLabel
        }
    }
    
    private var _profileImageView: UIImageView?
    private var profileImageView: UIImageView {
        get {
            if let profileImageView = _profileImageView {
                return profileImageView
            }
            let profileImageView = UIImageView()
            _profileImageView = profileImageView
            cellView.addSubview(profileImageView)
            self.addConstraintForProfileImageView()
            
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.masksToBounds = true
            profileImageView.backgroundColor = .white
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.white.cgColor
            return profileImageView
        }
    }
    
    private var _postTimeLabel: UILabel?
    private var postTimeLabel: UILabel {
        get {
            if let postTimeLabel = _postTimeLabel{
                return postTimeLabel
            }
            let postTimeLabel = UILabel()
            _postTimeLabel = postTimeLabel
            cellView.addSubview(postTimeLabel)
            self.addConstraintForPostTimeLabel()
            
            postTimeLabel.sizeToFit()
            postTimeLabel.numberOfLines = 0
            postTimeLabel.textColor = UIColor.white
            postTimeLabel.font = UIFont.openSansRegular(size: 8)
            
            return postTimeLabel
        }
    }
    
    private var _userTextLabel: UILabel?
    private var userTextLabel: UILabel {
        get {
            if let userTextLabel = _userTextLabel {
                return userTextLabel
            }
            let userTextLabel = UILabel()
            _userTextLabel = userTextLabel
            cellView.addSubview(userTextLabel)
            self.addConstraintForUserTextLabel()
            
            userTextLabel.font = UIFont.openSansRegular(size: 8)
            userTextLabel.sizeToFit()
            userTextLabel.numberOfLines = 1
            userTextLabel.textColor = .white
            return userTextLabel
        }
    }
    
    private var _commentsView: UIView?
    private var commentsView: UIView {
        get {
            if let commentsView = _commentsView {
                return commentsView
            }
            let commentsView = UIView()
            _commentsView = commentsView
            cellView.addSubview(commentsView)
            self.addConstraintForCommentsView()
            
            commentsView.backgroundColor = UIColor.black
            commentsView.layer.cornerRadius = 5
            commentsView.setDimensions(height: 13, width: 32)
            return commentsView
        }
    }
    
    private var _commentIcon: UIImageView?
    private var commentIcon: UIImageView {
        get {
            if let commentIcon = _commentIcon{
                return commentIcon
            }
            
            let commentIcon = UIImageView()
            _commentIcon = commentIcon
            commentsView.addSubview(commentIcon)
            self.addConstraintForCommentIcon()
            
            commentIcon.contentMode = .scaleAspectFill
            return commentIcon
        }
    }
    
    private var _commentsLabel: UILabel?
    private var commentsLabel: UILabel {
        get {
            if let commentsLabel = _commentsLabel {
                return commentsLabel
            }
            
            let commentsLabel = UILabel()
            _commentsLabel = commentsLabel
            commentsView.addSubview(commentsLabel)
            self.addConstraintForCommentsLabel()
            
            commentsLabel.numberOfLines = 1
            commentsLabel.textColor = .white
            commentsLabel.font = UIFont.RobotoRegular(size: 8)
            commentsLabel.text = "45"
            commentsLabel.textAlignment = .center
            commentsLabel.addCharacterSpacing(kernValue: -0.8)
            return commentsLabel
            
        }
    }
    
    private var _likesView: UIView?
    private var likesView: UIView {
        get {
            if let likesView = _likesView {
                return likesView
            }
            
            let likesView = UIView()
            _likesView = likesView
            cellView.addSubview(likesView)
            self.addConstraintForLikesView()
            
            likesView.backgroundColor = UIColor.black
            likesView.layer.cornerRadius = 5
            likesView.setDimensions(height: 13, width: 32)
            return likesView
        }
        
    }
    
    private var _likesIcon: UIImageView?
    private var likesIcon: UIImageView {
        get {
            if let likesIcon = _likesIcon{
                return likesIcon
            }
            
            let likesIcon = UIImageView()
            _likesIcon = likesIcon
            likesView.addSubview(likesIcon)
            self.addConstraintForlikesIcon()
            
            likesIcon.contentMode = .scaleAspectFill
            return likesIcon
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
            likesView.addSubview(likesLabel)
            self.addConstraintForLikesLabel()
            
            likesLabel.numberOfLines = 1
            likesLabel.textColor = .white
            likesLabel.font = UIFont.RobotoRegular(size: 8)
            likesLabel.text = "45"
            likesLabel.textAlignment = .center
            likesLabel.addCharacterSpacing(kernValue: -0.8)
            return likesLabel
        }
    }
}



extension PostCell {
    
    func configure () {
        guard let viewModel = viewModel else { return }
        
        //Post
        imageView.sd_setImage(with: viewModel.imageUrl)
        commentsLabel.text = viewModel.commentsLabelText
        likesLabel.text = viewModel.likesLabelText
        commentIcon.image = #imageLiteral(resourceName: "CommentsIcon")
        likesIcon.image = #imageLiteral(resourceName: "LikesIcon")
        
        //User
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        titleTextLabel.text = viewModel.title
        postTimeLabel.text = "20 hours ago"
        userTextLabel.text = viewModel.userFullName
    }
    
    func addConstraintsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, right: cellView.rightAnchor)
        
        let imageViewHeightLayoutConstraint =
            NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: imageHeight
        )
        imageView.addConstraint(imageViewHeightLayoutConstraint)
        self.imageViewHeightLayoutConstraint = imageViewHeightLayoutConstraint
    }
    
    func addConstraintForTitleTextLabel() {
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextLabel.anchor(top: imageView.bottomAnchor, left: profileImageView.rightAnchor, right: cellView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 10, paddingRight: 5)
    }
    
    func addConstraintForProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.anchor(top: imageView.bottomAnchor, left: cellView.leftAnchor, paddingTop: 6, paddingLeft: 5)
        profileImageView.setDimensions(height: 20, width: 20)
        profileImageView.layer.cornerRadius = 20/2
    }
    
    func addConstraintForUserTextLabel() {
        userTextLabel.translatesAutoresizingMaskIntoConstraints = false
        userTextLabel.anchor(top: titleTextLabel.bottomAnchor, left: titleTextLabel.leftAnchor, right: postTimeLabel.leftAnchor, paddingTop: 1, paddingBottom: 5, paddingRight: 6)
    }
    
    func addConstraintForPostTimeLabel() {
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.anchor(top: titleTextLabel.bottomAnchor, right: cellView.rightAnchor, paddingTop: 1, paddingBottom: 5, paddingRight: 5)
        postTimeLabel.setWidth(53)
    }
    
    func addConstraintForCommentsView() {
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.anchor(top: cellView.topAnchor, right: cellView.rightAnchor, paddingTop: 10, paddingRight: 10)
    }
    
    func addConstraintForCommentIcon() {
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        commentIcon.anchor(top: commentsView.topAnchor, right: commentsView.rightAnchor, paddingTop: 3, paddingRight: 3)
        commentIcon.setDimensions(height: 8, width: 8)
    }
    
    func addConstraintForCommentsLabel() {
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.anchor(top: commentsView.topAnchor, left: commentsView.leftAnchor, paddingTop: 2, paddingLeft: 4)
        commentsLabel.setWidth(15)
    }
    
    func addConstraintForLikesView() {
        likesView.translatesAutoresizingMaskIntoConstraints = false
        likesView.anchor(top: cellView.topAnchor, right: commentsView.leftAnchor, paddingTop: 10, paddingRight: 5)
    }
    
    func addConstraintForlikesIcon() {
        likesIcon.translatesAutoresizingMaskIntoConstraints = false
        likesIcon.anchor(top: likesView.topAnchor, right: likesView.rightAnchor, paddingTop: 2, paddingRight: 3)
        likesIcon.setDimensions(height: 8, width: 8)
    }
    
    func addConstraintForLikesLabel() {
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.anchor(top: likesView.topAnchor, left: likesView.leftAnchor, paddingTop: 2, paddingLeft: 4)
        likesLabel.setWidth(15)
    }
    
    
    
}
