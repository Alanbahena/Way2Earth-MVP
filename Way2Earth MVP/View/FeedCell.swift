//
//  FeedCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let feedCellIdentifier = "FeedCell"

class FeedCell: UICollectionViewCell {
    
    static let annotationPadding: CGFloat = 11
    
    var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 13
            imageView.image = #imageLiteral(resourceName: "photo1")
            return imageView
       }()
    
    lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView,annotationView])
        stack.axis = .vertical
        return stack
    }()
    
    private var annotationView: UIView = {
        let annotationView = UIView()
        annotationView.sizeToFit()
        return annotationView
    }()
    
    private var titleTextLabel: UILabel = {
        var label = UILabel()
        
        label.font = UIFont.merriWeatherBold(size: 10)
        label.sizeToFit()
        label.numberOfLines = 2
        label.textColor = .white
        label.text = "Hello World today we have achieved something pretty muhc amazing! "
        return label
    }()
    
    private var profileImageView: UIImageView = {
       let profileImageView = UIImageView()
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.backgroundColor = .white
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.image = #imageLiteral(resourceName: "profileImage")
        return profileImageView
    }()
    
    private var userTextLabel: UILabel = {
        let userTextLabel = UILabel()
        userTextLabel.font = UIFont.openSansRegular(size: 8)
        userTextLabel.sizeToFit()
        userTextLabel.numberOfLines = 1
        userTextLabel.textColor = .white
        userTextLabel.text = "Alan Bahena"
        return userTextLabel
    }()
    
    private var postTimeLabel: UILabel = {
        let postTimeLabel = UILabel()
        postTimeLabel.sizeToFit()
        postTimeLabel.numberOfLines = 0
        postTimeLabel.textColor = UIColor.white
        postTimeLabel.font = UIFont.openSansRegular(size: 8)
        postTimeLabel.text = "20 hours ago"
        
        return postTimeLabel
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [likesView,commentsView])
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    
    private var likesView: UIView = {
        let likesView = UIView()
        likesView.backgroundColor = .black
        likesView.layer.cornerRadius = 5
        return likesView
    }()
    
    private var commentsView: UIView = {
        let commentsView = UIView()
        commentsView.backgroundColor = .black
        commentsView.layer.cornerRadius = 5
        return commentsView
    }()
    
    private var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.numberOfLines = 1
        likesLabel.textColor = .white
        likesLabel.font = .systemFont(ofSize: 8)
        likesLabel.text = "255"
        likesLabel.textAlignment = .center
        likesLabel.addCharacterSpacing(kernValue: -1.0)
        return likesLabel
    }()
    
    private var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.numberOfLines = 1
        commentLabel.textColor = .white
        commentLabel.font = .systemFont(ofSize: 8)
        commentLabel.text = "45"
        commentLabel.textAlignment = .center
        commentLabel.addCharacterSpacing(kernValue: -1.0)
        return commentLabel
    }()
    
    private var likesIcon:UIImageView = {
        let likesIcon = UIImageView()
        likesIcon.contentMode = .scaleAspectFill
        likesIcon.image = #imageLiteral(resourceName: "LikesIcon")
        return likesIcon
    }()
    
    private var commentIcon: UIImageView = {
        let commentIcon =  UIImageView()
        commentIcon.contentMode = .scaleAspectFill
        commentIcon.image = #imageLiteral(resourceName: "CommentsIcon")
        return commentIcon
    }()
    
    
    
    
        
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Adding VerticalStackView
        addVerticalStackViewConstraint()
        
        //AnnotationView Constraint
        addAnnotationViewConstraint()
        
        //ProfileImageView Constraint
        addProfileImageViewConstraint()
        
        //TitleTextLabel
        titleTextLabelConstraint()
        
        //PostTimeLabel
        addPostTimeLabelConstraint()
        
        //UserTextLabel
        addUserTextConstraint()
        
        //horizontalStack
        addhorizontalStackViewConstraint()
        
        //LikesView
        addLikesViewConstraint()
        
        //commentsView
        addCommentsViewConstraint()
        
        //likesLabel
        addLikesLabelConstraint()
        
        //LikesIcon
        addLikesIconConstraint()
        
        //CommentLabel
        addCommentLabel()
        
        //CommentIcon
        addcommentIcon()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

    //MARK: - Constraints
    
extension FeedCell {
    
    func addProfileImageViewConstraint() {
        annotationView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.anchor(top: imageView.bottomAnchor, left: contentView.leftAnchor, paddingTop: 6, paddingLeft: 5)
        profileImageView.setDimensions(height: 20, width: 20)
        profileImageView.layer.cornerRadius = 20/2
    }
    
    func addVerticalStackViewConstraint () {
        contentView.addSubview(verticalStackView)
        verticalStackView.frame = contentView.frame
    }
    
    func addAnnotationViewConstraint() {
        let titleTextLabelHeight = titleTextLabel.text?.heightForWidth(width: contentView.bounds.width, font: .systemFont(ofSize: 10))
        let userTextLabelHeight = userTextLabel.text?.heightForWidth(width: contentView.bounds.width, font: .systemFont(ofSize: 8))
        
        annotationView.anchor(top: imageView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        annotationView.setHeight(titleTextLabelHeight! + userTextLabelHeight!)
    }
    
    func titleTextLabelConstraint () {
        annotationView.addSubview(titleTextLabel)
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextLabel.anchor(top: annotationView.topAnchor, left: profileImageView.rightAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 10, paddingRight: 5)
    }
    
    func addUserTextConstraint () {
        annotationView.addSubview(userTextLabel)
        userTextLabel.translatesAutoresizingMaskIntoConstraints = false
        userTextLabel.anchor(top: titleTextLabel.bottomAnchor, left: titleTextLabel.leftAnchor, right: postTimeLabel.leftAnchor, paddingTop: 1, paddingBottom: 5, paddingRight: 6)
    }
    
    func addPostTimeLabelConstraint() {
        annotationView.addSubview(postTimeLabel)
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.anchor(top: titleTextLabel.bottomAnchor, right: annotationView.rightAnchor, paddingTop: 1, paddingBottom: 5, paddingRight: 5)
        postTimeLabel.setWidth(53)
    }
    
    func addhorizontalStackViewConstraint() {
        contentView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingRight: 5)
        horizontalStack.setDimensions(height: 13, width: 69)
    }
    
    func addLikesViewConstraint() {
        likesView.setDimensions(height: 13, width: 32)
    }
    
    func addCommentsViewConstraint() {
        commentsView.setDimensions(height: 13, width: 32)
    }
    
    func addLikesLabelConstraint() {
        likesView.addSubview(likesLabel)
        likesLabel.anchor(top: likesView.topAnchor, left: likesView.leftAnchor, paddingTop: 2, paddingLeft: 4)
        likesLabel.setWidth(15)
    }
    
    func addLikesIconConstraint() {
        likesView.addSubview(likesIcon)
        likesIcon.anchor(top: likesView.topAnchor, right: likesView.rightAnchor, paddingTop: 2, paddingRight: 4)
        likesIcon.setDimensions(height: 8, width: 8)
    }
    
    func addCommentLabel() {
        commentsView.addSubview(commentLabel)
        commentLabel.anchor(top: commentsView.topAnchor, left: commentsView.leftAnchor, paddingTop: 2, paddingLeft: 4)
        commentLabel.setWidth(15)
    }
    
    func addcommentIcon() {
        commentsView.addSubview(commentIcon)
        commentIcon.anchor(top: commentsView.topAnchor, right: commentsView.rightAnchor, paddingTop: 3, paddingRight: 3)
        commentIcon.setDimensions(height: 8, width: 8)
    }
    
    
    
}
