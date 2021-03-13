//
//  FeedController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import Firebase

protocol FeedLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

class FeedController: UICollectionViewController {
    
    let items: [LayoutItem] = [
        LayoutItem(image: UIImage(named: "photo1")!, titleText: "hello world", profileImage: UIImage(named: "profileImage")!, userText: "Alan Bahena", postTime: "20 hours ago")
    ]
    
    //MARK: - Lifecycle
    
    private var posts = [Post]()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
        setUpCollectionViewInsets()
        setUpLayout()
        
        fetchPosts()
        
    }
    
    //MARK: - Actions

    @objc func handleLogOut() {
        do {
            try Auth.auth().signOut()
            let controller = WelcomeController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    //MARK: - API
    
    func fetchPosts() {
        PostService.fetchPost { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func setUpCollectionViewInsets() {
        collectionView.backgroundColor = UIColor.spaceColor
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 5, bottom: 5, right: 5)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    func setUpLayout() {
        if let layout = collectionView.collectionViewLayout as? FeedLayout {
            layout.delegate = self
        }
    }
}


    //MARK: - CustomDelegate

extension FeedController: FeedLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let image = #imageLiteral(resourceName: "photo1")
        return image.height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        
        let titleText = posts[indexPath.item].title
        let font = UIFont.systemFont(ofSize: 10)
        let titleTextHeight = titleText.heightForWidth(width: withWidth, font: font)
        
        let userText = posts[indexPath.item].title
        let userFont = UIFont.systemFont(ofSize: 8)
        let userTextHeight = userText.heightForWidth(width: withWidth, font: userFont)
        
        return titleTextHeight + userTextHeight + FeedCell.annotationPadding

    }
}

    //MARK: - UIColllectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellIdentifier, for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
}
