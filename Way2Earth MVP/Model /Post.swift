//
//  Post.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/11/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Firebase

struct Post {
    
    var description: String
    var title: String
    var likes: Int
    var comments: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    let ownerImageUrl: String
    let ownerFullName: String
    
    init(postId: String, dictionary: [String: Any]) {
        self.description = dictionary["description"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.comments = dictionary["comments"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.postId = postId
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerFullName = dictionary["ownerFullName"] as? String ?? ""
    }
    
}
