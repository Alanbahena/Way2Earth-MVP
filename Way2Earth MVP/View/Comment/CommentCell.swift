//
//  CommentCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/18/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let commentCellIdentifier = "CommentCell"

class CommentCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: CommentViewModel? {
        didSet{ configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(size: 12)
        label.numberOfLines = 1
        label.textColor = .init(white: 1, alpha: 0.7)
        label.textAlignment = .left
        label.text = "Alan Bahena"
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.RobotoRegular(size: 12)
        label.numberOfLines = 1
        label.textColor = .init(white: 1, alpha: 0.7)
        label.textAlignment = .left
        label.text = "5min ago"
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.RobotoRegular(size: 12)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Just some comments for now ..."
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 10)
        profileImageView.setDimensions(height: 35, width: 35)
        profileImageView.layer.cornerRadius = 35/2
        
        addSubview(userNameLabel)
        userNameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, paddingTop: 12, paddingLeft: 10)
        
        addSubview(commentLabel)
        commentLabel.anchor(top: userNameLabel.bottomAnchor, left: userNameLabel.leftAnchor, right: rightAnchor, paddingTop: 2, paddingRight: 10)
        
        addSubview(timeLabel)
        timeLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        userNameLabel.text = viewModel.userName
        commentLabel.text = viewModel.commentText
        
    }
}
