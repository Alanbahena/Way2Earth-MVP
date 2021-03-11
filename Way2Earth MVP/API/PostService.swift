//
//  PostService.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/10/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(image: UIImage, title: String, description: String, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["title": title, "description": description, "timestamp": Timestamp(date: Date()), "likes": 0, "comments": 0, "imageUrl": imageUrl, "ownerUid" : uid] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
}
