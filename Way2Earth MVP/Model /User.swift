//
//  User.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/4/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Foundation

struct User {
    
    let email: String
    let fullName: String
    let profileImageUrl: String
    let userName: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.profileImageUrl = dictionary["ProfileImageUrl"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
