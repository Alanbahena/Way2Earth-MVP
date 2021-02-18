//
//  MainTabController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    // MARK: - Helpers
    
    func configureViewController() {
        
        let layout = CustomLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Home_unselected"), selectedImage: #imageLiteral(resourceName: "Home_selected "), rootViewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Search_unselected"), selectedImage: #imageLiteral(resourceName: "Search_selected"), rootViewController: SearchController())
        let postCreator = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Create"), selectedImage:#imageLiteral(resourceName: "Create"), rootViewController: PostCreatorController())
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Notifications_unselected"), selectedImage: #imageLiteral(resourceName: "Notifications_selected"), rootViewController: NotificationsController())
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "Profile_unselected"), selectedImage: #imageLiteral(resourceName: "Profile_selected"), rootViewController: ProfileController())
        
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
