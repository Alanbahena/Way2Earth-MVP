//
//  SearchResultsViewCell.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/8/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

let searchResutlsCellIdentifier = "SearchResutlsCell"

class SearchRestulsCell: UITableViewCell {
    
    //MARK: - Properties
    
    var viewModel: SearchResultsCellViewModel? {
        didSet { configure ()}
    }
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "profileImage")
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.RobotoRegular(size: 14)
        label.text = "@alanbahena"
        label.textColor = .white
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(size: 14)
        label.text = "Alan Bahena"
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [fullNameLabel, userNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        userNameLabel.text = viewModel.userName
        fullNameLabel.text = viewModel.fullName
    }
}
