//
//  InputTextView.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/10/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class InputTextField: UITextView {
    
    //MARK: - Properties
    
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText}
    }
    
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(white: 1, alpha: 0.7)
        label.font = UIFont.RobotoRegular(size: 14)
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeHolderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
                placeHolderLabel.centerY(inView: self)
            } else {
                placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 4)
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeHolderLabel)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleTextDidChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
    
}

class DescriptionInputTextField: UITextView {
    
    //MARK: - Properties
    
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText}
    }
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(white: 1, alpha: 0.7)
        label.font = UIFont.RobotoRegular(size: 14)
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleTextDidChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
