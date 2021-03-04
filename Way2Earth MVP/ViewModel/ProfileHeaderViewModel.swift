//
//  ProfileHeaderViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/4/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Foundation

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
    
    init(user: User) {
        self.user = user
    }
}
