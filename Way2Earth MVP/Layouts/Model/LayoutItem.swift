//
//  LayoutItem.swift
//  Test6
//
//  Created by Alan Bahena on 2/13/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//


import UIKit

struct LayoutItem {
    
    var image: UIImage
    var titleText: String
    var profileImage: UIImage
    var userText: String
    var postTime: String
    
    init(image: UIImage, titleText: String, profileImage: UIImage, userText: String, postTime: String){
        self.image = image
        self.titleText = titleText
        self.profileImage = profileImage
        self.userText = userText
        self.postTime = postTime
    }
    
}
