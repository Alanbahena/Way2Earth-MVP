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
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewController(withUser: user)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfUserIsLoggedIn()
        fetchUser()
        
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { (user) in
            self.user = user
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = WelcomeController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }

    // MARK: - Helpers
    
    func configureViewController(withUser user: User) {
        
        let layout = FeedLayout() 
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "NewsFeed_unselected"), selectedImage: #imageLiteral(resourceName: "NewsFeed_selected "), rootViewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Search_unselected"), selectedImage: #imageLiteral(resourceName: "Search_selected"), rootViewController: SearchController())
        let postCreator = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Create_unselected"), selectedImage:#imageLiteral(resourceName: "Create_unselected"), rootViewController: PostCreatorController())
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Notifications_unselected"), selectedImage: #imageLiteral(resourceName: "Notifications_selected"), rootViewController: NotificationsController())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Profile_unselected"), selectedImage: #imageLiteral(resourceName: "Profile_selected"), rootViewController: profileController)
        
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
        nav.navigationBar.barTintColor = .spaceColor

        
        return nav
    }
}

extension MainTabController: AuthenticationDelegate {
    func autehnticationDidComplete() {
        fetchUser()
        self.dismiss(animated: false, completion: nil)
    }
}
