//
//  AuthenticationViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/24/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import Foundation
import UIKit

protocol FormViewModel {
    func updateForm() 
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false 
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor.buttonbackgroundBlueColor : UIColor.buttonUnabledbackgroundBlueColor
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? UIColor(white: 1, alpha: 0.9) : UIColor(white: 1, alpha: 0.9)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
 
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
 
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullName?.isEmpty == false && userName?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor.buttonbackgroundBlueColor : UIColor.buttonUnabledbackgroundBlueColor
    }
    
}
