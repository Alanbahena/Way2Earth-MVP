//
//  EditProfileController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/3/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    
    //MARK: - Properties
    
    private var profileBackgroundImage: UIImageView = {
        let profileBI = UIImageView()
        profileBI.backgroundColor = .lightGray
        profileBI.contentMode = .scaleToFill
        return profileBI
    }()
    
    private var profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = .lightGray
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        return profileImage
    }()
    
    
    private var changeProfilePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Profile Photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.RobotoRegular(size: 14)
        return button
    }()
    
    private var bioLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.robotoBold(size: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Bio"
        return label
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        configureUI()
        
    }
    
    //MARK: - Actions
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .spaceColor
        
        //ProfileBackgroundImage
        view.addSubview(profileBackgroundImage)
        profileBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        profileBackgroundImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        profileBackgroundImage.setHeight(150)
        
        //ProfileImageView
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        profileImageView.centerX(inView: view)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        
        //ChangeProfilePhoto
        view.addSubview(changeProfilePhotoButton)
        changeProfilePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        changeProfilePhotoButton.centerX(inView: view)
        changeProfilePhotoButton.anchor(top: profileImageView.bottomAnchor, paddingTop: 10)
        
        //BioLabel
        view.addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.anchor(top: changeProfilePhotoButton.bottomAnchor, left: view.leftAnchor, paddingTop: 50, paddingLeft: 50)
    }
}

