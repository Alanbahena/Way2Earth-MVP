//
//  ProfileController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import AVFoundation

protocol ProfileLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize
}

class ProfileController: UICollectionViewController {
    
    //MARK: - Properties
    
    private var user: User
    private var posts = [Post]()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: ProfileLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViewInsets()
        setUpLayout()
        
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchPosts()
    }
    
    //MARK: - API
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserisFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    func fetchPosts() {
        PostService.fetchPosts(forUser: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }

    
    //MARK: - Helpers
    
    func setUpCollectionViewInsets() {
        collectionView.backgroundColor = UIColor.spaceColor
        // -45 is the isnet that touch the top anchor of the superview
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderIdentifier)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellIdentifier)
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
        
        let url = URL(string: posts[indexPath.item].imageUrl)
        let imageSize = sizeOfImageAt(url: url!)
        let boundingRect = CGRect(x: 0, y: 0, width: withWidth, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: imageSize! , insideRect: boundingRect)

        return rect.size.height
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let titleTextWidth = withWidth - PostCell.titleTextWidth
        //TitleText
        let titleText = posts[indexPath.item].title
        let font = UIFont.merriWeatherBold(size: 10)
        let titleTextHeight = titleText.heightForWidth(width: titleTextWidth, font: font)
        //UserText
        let userText = posts[indexPath.item].ownerFullName
        let userFont = UIFont.openSansRegular(size: 8)
        let userTextHeight = userText.heightForWidth(width: withWidth, font: userFont)

        return titleTextHeight + userTextHeight + FeedCell.annotationPadding
    }
    
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 360)
    }
}

    //MARK: - UICOllecitonViewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: profileHeaderIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        
        header.viewModel = ProfileHeaderViewModel(user: user)
    
        return header
    }
}

    //MARK: - UICOllectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PostController(collectionViewLayout: PostLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: false)
    }
}

    //MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func header(_profileHeader: ProfileHeader, didTapSettingsButton user: User) {
        let controller = ProfileSettingsController()
        navigationController?.pushViewController(controller, animated: false)
    }
    
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        guard let tab = tabBarController as? MainTabController else { return }
        guard let currentUser = tab.user else { return }
        
        if user.isCurrentUser {
            print("DEBUG: Show Edit profile here ..")
//            let controller = EditProfileController()
            //        navigationController?.pushViewController(controller, animated: false)
        } else if user.isFollowed {
            UserService.unFollow(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                
                NotificationService.uploadNotification(toUid: user.uid, fromUser: currentUser, type: .follow)
            }
        }
    }
}

    //MARK: - URLSizeOfImage

extension ProfileController {
    
    func sizeOfImageAt(url: URL) -> CGSize? {
            // with CGImageSource we avoid loading the whole image into memory
            guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
                return nil
            }

            let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
                return nil
            }

            if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
                let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
                return CGSize(width: width, height: height)
            } else {
                return nil
            }
        }
}
