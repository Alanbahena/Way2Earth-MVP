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
    
    static func uploadPost(image: UIImage, title: String, description: String, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["title": title, "description": description, "timestamp": Timestamp(date: Date()), "likes": 0, "comments": 0, "imageUrl": imageUrl, "ownerUid" : uid, "ownerImageUrl": user.profileImageUrl, "ownerFullName": user.fullName] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPost(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
}
