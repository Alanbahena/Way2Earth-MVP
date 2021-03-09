//
//  ProfileHeaderViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/4/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var profileNameLabel: String {
        return user.fullName
    }
    
    var userName: String {
        return user.userName
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtontext: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStatText(value: user.stats.following, label: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStatText(value: 5, label: "posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedtext = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.robotoBold(size: 14), .foregroundColor: UIColor.white])
        attributedtext.append(NSAttributedString(string: label, attributes: [.font: UIFont.RobotoRegular(size: 14), .foregroundColor: UIColor.init(white: 1, alpha: 0.7)]))
        return attributedtext
    }
}
