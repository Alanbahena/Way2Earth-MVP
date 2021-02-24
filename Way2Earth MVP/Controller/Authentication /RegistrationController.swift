//
//  RegistrationController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/23/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = RegistrationViewModel() 
    
    private let viewBackground:UIImageView = {
        let viewBackground = UIImageView(image: #imageLiteral(resourceName: "earth"))
        viewBackground.clipsToBounds = true
        viewBackground.contentMode = .scaleAspectFill
        viewBackground.alpha = 0.4
        return viewBackground
    }()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .init(white: 1, alpha: 0.7)
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
       return button
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField = CustomTextField(placeholder: "Fullname")

    private let userNameTextField = CustomTextField(placeholder: "Username")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.init(white: 1, alpha: 0.9), for: .normal)
        button.titleLabel?.font = UIFont.merriWeatherBold(size: 18)
        button.backgroundColor = .buttonUnabledbackgroundBlueColor
        button.layer.cornerRadius = 10
        button.setHeight(45)
        button.isEnabled = false 
        return button
    }()
    
    private let alreadyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationsObservers()
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleShowLogIn() {
        let controller = LoginController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullNameTextField {
            viewModel.fullName = sender.text
        } else {
            viewModel.userName = sender.text
        }
        updateForm()
    }
    
    @objc func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .spaceColor
        
        view.addSubview(viewBackground)
        viewBackground.frame = view.frame
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 25
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 35, paddingRight: 35)
        
        view.addSubview(alreadyAccountButton)
        alreadyAccountButton.centerX(inView: view)
        alreadyAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    }
    
    func configureNotificationsObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: - FormViewModel

extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

    //MARK: -  UIImagePickerControllerDelegate


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
