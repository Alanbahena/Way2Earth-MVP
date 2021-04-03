//
//  CommentInputAccesoryView.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/18/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

protocol CommentInputAccesoryViewDelegate: class {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String)
}

class CommentInputAccesoryView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: CommentInputAccesoryViewDelegate?
    
    private let commentTextView: InputTextField = {
        let tv = InputTextField()
        tv.placeHolderText = "Enter comment.."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isScrollEnabled = false
        tv.placeholderShouldCenter = true
        return tv
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    //MARK: - Actions
    
    @objc func handlePostTapped() {
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    //MARK: - Helper
    
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeHolderLabel.isHidden = false 
    }
}
