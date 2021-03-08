//
//  SearchResutlsCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/8/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Foundation

struct SearchResultsCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var userName: String {
        return user.userName
    }
    
    var fullName: String {
        return user.fullName
    }
    
    init(user: User) {
        self.user = user
    }
}
