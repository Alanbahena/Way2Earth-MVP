//
//  CustomTextField.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/23/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 45, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        
        borderStyle = .none
        textColor = .spaceColor
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.45)
        setHeight(45)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.placeHolderSpaceColor])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
