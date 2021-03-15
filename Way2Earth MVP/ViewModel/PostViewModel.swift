//
//  PostViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/11/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var title: String { return post.title }
    
    var description: String { return post.description }
    
    var userProfileImageUrl : URL? { return URL(string: post.ownerImageUrl)}
    
    var userFullName: String { return post.ownerFullName}
    
    var likes: Int { return post.likes }
    
    var comments: Int { return post.comments }
    
    var likesLabelText: String { return "\(post.likes)" }
    
    var commentsLabelText: String { return "\(post.comments)"}
    
    init(post: Post) {
        self.post = post
    }
}
