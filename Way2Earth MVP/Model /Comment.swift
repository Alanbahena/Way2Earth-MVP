//
//  Comment.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/22/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Firebase

struct Comment {
    let uid: String
    let userName: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String
    
    init (dictionary: [ String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.commentText = dictionary["comment"] as? String ?? ""
    }
}
