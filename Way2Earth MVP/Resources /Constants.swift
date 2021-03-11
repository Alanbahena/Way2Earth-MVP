//
//  Constants.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/4/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
