//
//  FeedCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/16/21.
//

import UIKit

let feedCellIdentifier = "FeedCell"

class FeedCell: UICollectionViewCell {
    
    static let annotationPadding: CGFloat = 5
    
    private var _roundedCornersView: UIView?
    private var roundedCornersView: UIView {
        get {
            if let roundedCornersView = _roundedCornersView {
                return roundedCornersView
            }
            
            let roundedCornersView = UIView(frame: bounds)
            _roundedCornersView = roundedCornersView
            
            contentView.addSubview(roundedCornersView)
            roundedCornersView.addConstraintsAlignedToSuperview()
            
            roundedCornersView.clipsToBounds = true
            
            return roundedCornersView
        }
    }
    
    private var _imageView: UIImageView?
    var imageView: UIImageView {
        get {
            if let imageView = _imageView {
                return imageView
            }
            let imageView = UIImageView()
            _imageView = imageView
            
            roundedCornersView.addSubview(imageView)
            self.addConstraintsForImageView()
            
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 13
            
            return imageView
        }
    }
    
    fileprivate var imageViewHeightLayoutConstraint: NSLayoutConstraint?
    fileprivate var imageHeight: CGFloat!
    
    override public func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? CustomLayoutAttributes {
            imageHeight = attributes.imageHeight
            if let imageViewHeightLayoutConstraint = self.imageViewHeightLayoutConstraint {
                imageViewHeightLayoutConstraint.constant = attributes.imageHeight
            }
        }
    }
    
    private var _profileImageView: UIImageView?
    var profileImageView: UIImageView {
        get {
            if let profileImageView = _profileImageView {
                return profileImageView
            }
            let profileImageView = UIImageView()
            _profileImageView = profileImageView
            
            roundedCornersView.addSubview(profileImageView)
            addConstraintForProfileImageView()
            
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.masksToBounds = true
            profileImageView.backgroundColor = .white
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.white.cgColor
            
            return profileImageView
        }
    }

    
    private var _titleTextLabel: UILabel?
    var titleTextLabel: UILabel {
        get {
            if let titleTextLabel = _titleTextLabel {
                return titleTextLabel
            }
            let titleTextLabel = UILabel()
            _titleTextLabel = titleTextLabel
            
            roundedCornersView.addSubview(titleTextLabel)
            
            titleTextLabel.font = .merriWeatherBold(size: 10)
            titleTextLabel.sizeToFit()
            titleTextLabel.numberOfLines = 2
            titleTextLabel.textColor = UIColor.white
            
            
            self.addConstraintsForLabel()

            return titleTextLabel
        }
    }
    
    private var _userText: UILabel?
    var userText: UILabel {
        get {
            if let userText = _userText {
                return userText
            }
            let userText = UILabel()
            _userText = userText
            
            roundedCornersView.addSubview(userText)
            
            addConstraintForUserText()
            
            userText.font = .openSansRegular(size: 8)
            userText.sizeToFit()
            userText.numberOfLines = 1
            userText.textColor = UIColor.white
            
            return userText
            
        }
    }
    
    private var _postTime: UILabel?
    var postTime: UILabel {
        get {
            if let postTime = _postTime {
                return postTime
            }
            let postTime = UILabel()
            _postTime = postTime
            
            roundedCornersView.addSubview(postTime)
            addConstraintForPostTime()
            
            postTime.sizeToFit()
            postTime.numberOfLines = 0
            postTime.textColor = UIColor.white
            postTime.font = .openSansRegular(size: 8)
            
            return postTime
            
        }
    }
    
    private var _commentsView: UIView?
    private var commentsView: UIView  {
        get {
            if let commentsView = _commentsView {
                return commentsView
            }
            let commentsView = UIView(frame: CGRect(x: 0, y: 0, width: 33, height: 13))
            _commentsView = commentsView
            
            imageView.addSubview(commentsView)
            addConstraintForCommentView()
            
            commentsView.backgroundColor = .white
            
            return commentsView
            
        }
    }
    
    
    

}

extension FeedCell {
    
    
    func addConstraintsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        roundedCornersView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .top,
                relatedBy: .equal,
                toItem: roundedCornersView,
                attribute: NSLayoutConstraint.Attribute.top,
                multiplier: 1,
                constant: 0
            )
        )
        roundedCornersView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .leading,
                relatedBy: .equal,
                toItem: roundedCornersView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        )
        roundedCornersView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: roundedCornersView,
                attribute: .trailing,
                multiplier: 1,
                constant: 0
            )
        )
        
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
    
    func addConstraintsForLabel() {
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextLabel.anchor(top: imageView.bottomAnchor, left: profileImageView.rightAnchor, right: roundedCornersView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 10, paddingRight: 5)
    }
    
    func addConstraintForProfileImageView() {
        profileImageView.anchor(top: imageView.bottomAnchor, left: roundedCornersView.leftAnchor, paddingTop: 6, paddingLeft: 5)
        profileImageView.setDimensions(height: 20, width: 20)
        profileImageView.layer.cornerRadius = 20 / 2
    }
    
    func addConstraintForUserText() {
        userText.anchor(top: titleTextLabel.bottomAnchor, left: titleTextLabel.leftAnchor,paddingTop: 1)
        userText.setWidth(70)
    }
    
    func addConstraintForPostTime() {
        postTime.anchor(top: titleTextLabel.bottomAnchor, left: userText.rightAnchor, right: titleTextLabel.rightAnchor , paddingTop: 1, paddingLeft: 10, paddingBottom: 5)
    }
    
    func addConstraintForCommentView() {
        commentsView.translatesAutoresizingMaskIntoConstraints = false
//        commentsView.setDimensions(height: 13, width: 33)
        commentsView.anchor(top: imageView.topAnchor, right: imageView.rightAnchor, paddingTop: 10, paddingRight: 10)
    }
    
}
