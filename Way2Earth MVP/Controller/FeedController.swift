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
        
        setUpCollectionViewInsets()
        setUpLayout()
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellIdentifier)
        
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
    
    //MARK: - Helpers
    
    func setUpCollectionViewInsets() {
        collectionView.backgroundColor = UIColor.spaceColor
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
}

    //MARK: - UIColllectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellIdentifier, for: indexPath) as! FeedCell
        
        return cell
    }
    
}
