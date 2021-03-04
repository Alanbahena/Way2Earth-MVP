//
//  ProfileController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

protocol HeaderDelegate: class {
    func didTapEdit()
}

protocol ProfileLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize
}

class ProfileController: UICollectionViewController {
    
    let items: [LayoutItem] = [
        LayoutItem(image: UIImage(named: "photo1")!, titleText: "hello world", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago")
    ]
    
    //MARK: - Properties
    
    var user: User? {
        didSet { collectionView.reloadData()}
    }
    
    //MARK: - Lifecycle
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViewInsets()
        setUpLayout()
        fetchUser()
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderIdentifier)
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { (user) in
            self.user = user
        }
    }
    
    //MARK: - Helpers
    
    func setUpCollectionViewInsets() {
        collectionView.backgroundColor = UIColor.spaceColor
        collectionView.contentInset = UIEdgeInsets(top: -45, left: 5, bottom: 5, right: 5)
    }
    
    func setUpLayout() {
        if let layout = collectionView.collectionViewLayout as? ProfileLayout {
            layout.delegate = self
        }
    }
}

    //MARK: - ProfileLayoutDelegate

extension ProfileController: ProfileLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        
        let image = items[indexPath.item].image
        return image.height(forWidth: withWidth)
        
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        
        let tittleText = items[indexPath.item].titleText
        let font = UIFont.merriWeatherBold(size: 10)
        let titleTextHeight = tittleText.heightForWidth(width: withWidth, font: font)
        
        let userText = items[indexPath.item].userText
        let userTextFont = UIFont.openSansRegular(size: 8)
        let userTextHeight = userText.heightForWidth(width: withWidth, font: userTextFont)
        
        if titleTextHeight > 24 {
            return 24 + userTextHeight + FeedCell.annotationPadding
        } else {
            return titleTextHeight + userTextHeight + FeedCell.annotationPadding
        }
    }
    
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 360)
    }
}

    //MARK: - UICOllecitonViewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: profileHeaderIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        } 
        return header
    }
    
}

    //MARK: - HeaderDelegate

extension ProfileController: HeaderDelegate {
    func didTapEdit() {
        let controller = EditProfileController()
        navigationController?.pushViewController(controller, animated: false)
    }
}
