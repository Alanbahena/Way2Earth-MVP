//
//  PostViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/11/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

struct PostViewModel {
    
    var post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var title: String { return post.title }
    
    var description: String { return post.description }
    
    var userProfileImageUrl : URL? { return URL(string: post.ownerImageUrl)}
    
    var userFullName: String { return post.ownerFullName}
    
    var likes: Int { return post.likes }
    
    var comments: Int { return post.comments }
    
    var likesLabelText: String { return "\(post.likes)" }
    
    var commentsLabelText: String { return "\(post.comments)"}
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .white : .white
    }
    
    var likeIconImage: UIImage? {
        let imageName = post.didLike ? "LikesIcon" : "likeunselected"
        return UIImage(named: imageName)
    }
    
    var timesTampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth ]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue() , to: Date()) ?? "2m"
    }
    
    init(post: Post) {
        self.post = post
    }
}
