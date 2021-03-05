//
//  WelcomeController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/23/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//
import UIKit

class WelcomeController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: AuthenticationDelegate?
    
    private let viewBackground:UIImageView = {
        let viewBackground = UIImageView(image: #imageLiteral(resourceName: "astronaut"))
        viewBackground.clipsToBounds = true
        viewBackground.contentMode = .scaleAspectFill
        viewBackground.alpha = 0.45
        return viewBackground
    }()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Way2EarthIcon"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var backGroundColor: UIColor {
        return UIColor(red: 7.0 / 255.0 , green: 9.0 / 255.0 , blue: 13.0 / 255.0 , alpha: 0.9)
    }
    
    private let signUpButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.backgroundColor = UIColor(red: 255.0 / 255.0 , green: 255.0 / 255.0 , blue: 255.0 / 255.0 , alpha: 0.45)
        sb.layer.cornerRadius = 15
        sb.setTitle("Start your Journey", for: .normal)
        sb.setTitleColor(UIColor.spaceColor, for: .normal)
        sb.titleLabel?.font = UIFont.merriWeatherBold(size: 18)
        sb.titleLabel?.alpha = 0.85
        sb.setHeight(42)
        sb.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return sb
    }()
    
    private let LogInButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.backgroundColor = UIColor(red: 7.0 / 255.0 , green: 9.0 / 255.0 , blue: 13.0 / 255.0 , alpha: 0.45)
        sb.layer.cornerRadius = 15
        sb.setTitle("Log In", for: .normal)
        sb.setTitleColor(UIColor.white, for: .normal)
        sb.titleLabel?.font = UIFont.merriWeatherBold(size: 18)
        sb.titleLabel?.alpha = 0.85
        sb.setHeight(42)
        sb.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return sb
    }()
    
   

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleShowLogIn() {
        let controller = LoginController()
        controller.delegate = delegate 
        navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: false)
    }
    
    
    //MARK: - Helpers
    
    func configureUI () {
        view.backgroundColor = UIColor.spaceColor
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(viewBackground)
        viewBackground.frame = view.frame
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 61, width: 193)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 65)
        
        let stack = UIStackView(arrangedSubviews: [signUpButton, LogInButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 35, paddingBottom: 65, paddingRight: 35)
    }
}
