//
//  NotificationCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 4/3/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let notificationCellIdentifier = "FeedCell"

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
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
        iv.image = #imageLiteral(resourceName: "profileImage")
        return iv
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(size: 15)
        label.text = "Alan Bahena"
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.RobotoRegular(size: 15)
        label.text = "Commented on yout Post"
        return label
    }()

    private let postImageView: UIImageView = {
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
        
        addSubview(backgroundAlpha)
        backgroundAlpha.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        backgroundAlpha.addSubview(profileImageView)
        profileImageView.centerY(inView: backgroundAlpha)
        profileImageView.anchor(left: backgroundAlpha.leftAnchor, paddingLeft: 10)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2

        addSubview(userNameLabel)
        userNameLabel.anchor(top: backgroundAlpha.topAnchor, left: profileImageView.rightAnchor, paddingTop: 12, paddingLeft: 10)

        addSubview(infoLabel)
        infoLabel.anchor(top: userNameLabel.bottomAnchor, left: userNameLabel.leftAnchor, right: rightAnchor, paddingTop: 2, paddingRight: 10)

        addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right: backgroundAlpha.rightAnchor, paddingRight: 12, width: 40, height: 40)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handlePostTapped() {
        
    }
}
