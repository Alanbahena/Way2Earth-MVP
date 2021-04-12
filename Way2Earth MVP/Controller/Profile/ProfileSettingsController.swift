//
//  ProfileSettingsController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 4/4/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import Firebase

class ProfileSettingsController: UIViewController {
    
    //MARK: - Properties
    
    private let LogOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .init(white: 1, alpha: 0.5)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.RobotoRegular(size: 20)
        
        button.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    //MARK: - API
    
    
    
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
    
    func configureTableView() {
        view.backgroundColor = .spaceColor
        navigationItem.title = "Settings"
        
        view.addSubview(LogOutButton)
        LogOutButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        LogOutButton.centerX(inView: view)
        LogOutButton.setDimensions(height: 50, width: 350)
    
    }
    
    
    
}
