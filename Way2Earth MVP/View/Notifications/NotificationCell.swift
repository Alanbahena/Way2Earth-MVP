//
//  NotificationCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 4/3/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate: class {
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String)
}

let notificationCellIdentifier = "FeedCell"

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
    var viewModel: NotificationViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: NotificationCellDelegate?
    
    let backgroundAlpha: UIView = {
       let iv = UIView()
        iv.backgroundColor = .init(white: 1, alpha: 0.1)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15 
        return iv
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.robotoBold(size: 15)
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.RobotoRegular(size: 15)
        return label
    }()
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.RobotoRegular(size: 15)
        label.textColor = .lightGray
        label.text = "2m"
        return label
    }()

    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray

        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(backgroundAlpha)
        backgroundAlpha.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        backgroundAlpha.addSubview(profileImageView)
        profileImageView.centerY(inView: backgroundAlpha)
        profileImageView.anchor(left: backgroundAlpha.leftAnchor, paddingLeft: 10)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2

        backgroundAlpha.addSubview(userNameLabel)
        userNameLabel.anchor(top: backgroundAlpha.topAnchor, left: profileImageView.rightAnchor, paddingTop: 12, paddingLeft: 10)

        backgroundAlpha.addSubview(infoLabel)
        infoLabel.anchor(top: userNameLabel.bottomAnchor, left: userNameLabel.leftAnchor, paddingTop: 3)
        
        backgroundAlpha.addSubview(timeLabel)
        timeLabel.anchor(top: userNameLabel.bottomAnchor, left: infoLabel.rightAnchor, paddingTop: 3, paddingLeft: 5)

        backgroundAlpha.addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right: backgroundAlpha.rightAnchor, paddingRight: 12, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handlePostTapped() {
        guard let postId = viewModel?.notification.postId else { return }
        delegate?.cell(self, wantsToViewPost: postId)
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        postImageView.sd_setImage(with: viewModel.postImageUrl)
        
        userNameLabel.text = viewModel.notificationUserName
        infoLabel.text = viewModel.notificationMessage
        timeLabel.text = viewModel.timestampString
        
        postImageView.isHidden = viewModel.shouldHidePostImage
        
    }
}
