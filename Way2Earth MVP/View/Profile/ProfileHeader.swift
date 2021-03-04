//
//  ProfileHeader.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/25/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import SDWebImage

let profileHeaderIdentifier = "ProfileCell"

class ProfileHeader: UICollectionReusableView {
 
    //MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: HeaderDelegate?
    
    var profileBackgroundImage: UIImageView = {
        let profileBI = UIImageView()
        profileBI.backgroundColor = .lightGray
        profileBI.contentMode = .scaleToFill
//        profileBI.image = #imageLiteral(resourceName: "profileBackground")
        return profileBI
    }()
    
    private let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = .lightGray
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        return profileImage
    }()
    
    private let profileNameLabel: UILabel = {
        let profileNameLabel = UILabel()
        profileNameLabel.font = UIFont.robotoBold(size: 20)
        profileNameLabel.sizeToFit()
        profileNameLabel.numberOfLines = 1
        profileNameLabel.textColor = .white
        profileNameLabel.textAlignment = .center
        return profileNameLabel
    }()
    
    private var userNameLabel: UILabel = {
        let userName = UILabel()
        userName.font = UIFont.RobotoRegular(size: 13)
        userName.sizeToFit()
        userName.numberOfLines = 1
        userName.textColor = .white
        userName.textAlignment = .center
        return userName
    }()
    
    private var descriptionLabel: UILabel = {
        let dl = UILabel()
        dl.font = UIFont.RobotoRegular(size: 13)
        dl.sizeToFit()
        dl.numberOfLines = 0
        dl.textColor = .white
        dl.textAlignment = .center
//        dl.text = "A person who loves to travel. The sky is not the limit"
        dl.text = ""
        return dl
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .init(white: 1, alpha: 0.7)
        button.titleLabel?.font = UIFont.robotoBold(size: 11)
        button.setTitleColor(.spaceColor, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 5, label: "Posts")
        return label
    }()
   
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 2, label: "Followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 1, label: "Following")
        return label
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .systemPink
        
        //profileBackgroundImage
        addSubview(profileBackgroundImage)
        profileBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        profileBackgroundImage.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        profileBackgroundImage.setHeight(150)
        
        //profileImageView
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        profileImageView.centerX(inView: profileBackgroundImage)
        profileImageView.anchor(top: topAnchor, paddingTop: 100)
        
        //profileUserTexts
        let UserStack = UIStackView(arrangedSubviews: [profileNameLabel, userNameLabel])
        UserStack.axis = .vertical
        UserStack.distribution = .fillProportionally
        addSubview(UserStack)
        UserStack.centerX(inView: profileBackgroundImage)
        UserStack.anchor(top: profileImageView.bottomAnchor, paddingTop: 10)
 
        //DescriptionLabel
        addSubview(descriptionLabel)
        descriptionLabel.centerX(inView: profileBackgroundImage)
        descriptionLabel.anchor(top: UserStack.bottomAnchor, paddingTop: 15)
        descriptionLabel.setWidth(200)
        
        //EditFollowButton
        addSubview(editProfileButton)
        editProfileButton.setDimensions(height: 25, width: 76)
        editProfileButton.anchor(top: profileBackgroundImage.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 15)
        
        //Followers/Posts/Following
        let stackFollowers = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stackFollowers.distribution = .fillEqually
        
        addSubview(stackFollowers)
        stackFollowers.centerX(inView: profileImageView)
        stackFollowers.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10 , paddingLeft: 25, paddingRight: 25)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleEditProfileFollowTapped() {
        delegate?.didTapEdit()
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let  viewModel = viewModel else { return }
        profileNameLabel.text = viewModel.profileNameLabel
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        userNameLabel.text = viewModel.userName
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedtext = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.robotoBold(size: 14), .foregroundColor: UIColor.white])
        attributedtext.append(NSAttributedString(string: label, attributes: [.font: UIFont.RobotoRegular(size: 14), .foregroundColor: UIColor.init(white: 1, alpha: 0.7)]))
        return attributedtext
    }
}
