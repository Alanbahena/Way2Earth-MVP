//
//  MainTabController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        checkIfUserIsLoggedIn()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = WelcomeController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }

    // MARK: - Helpers
    
    func configureViewController() {
        
        let layout = FeedLayout() 
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "NewsFeed_unselected"), selectedImage: #imageLiteral(resourceName: "NewsFeed_selected "), rootViewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Search_unselected"), selectedImage: #imageLiteral(resourceName: "Search_selected"), rootViewController: SearchController())
        let postCreator = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Create_unselected"), selectedImage:#imageLiteral(resourceName: "Create_unselected"), rootViewController: PostCreatorController())
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Notifications_unselected"), selectedImage: #imageLiteral(resourceName: "Notifications_selected"), rootViewController: NotificationsController())
        
        let profileLayout = ProfileLayout()
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Profile_unselected"), selectedImage: #imageLiteral(resourceName: "Profile_selected"), rootViewController: ProfileController(collectionViewLayout: profileLayout))
        
        viewControllers = [feed, search, postCreator, notifications, profile]
        
        tabBar.barTintColor = UIColor.spaceColor
        tabBar.tintColor = .white
        

    }
    
    func templateNavigationController(unselectedImage: UIImage,selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -25, right: 0)
        nav.navigationBar.tintColor = .white
        
        return nav
    }
}
