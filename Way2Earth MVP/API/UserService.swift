//
//  UserService.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/3/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
   
            let users = snapshot.documents.map( {User(dictionary: $0.data()) })
            completion(users)
        }
    }
}



