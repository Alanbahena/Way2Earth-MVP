//
//  CommentViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/22/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

struct CommentViewModel {
    
    private let comment: Comment
    
    var profileImageUrl: URL? { return URL(string: comment.profileImageUrl)}
    
    var userName: String { return comment.userName}
    
    var commentText: String { return comment.commentText }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
