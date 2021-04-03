//
//  UploadPostController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/9/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

protocol UploadPostControllerDelegate: class {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: UploadPostControllerDelegate?
    
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage}
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.robotoBold(size: 16)
        label.text = "Title"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var TitleTextView: InputTextField = {
        let tv = InputTextField()
        tv.placeHolderText = "Give a title to your Post"
        tv.placeholderShouldCenter = false 
        tv.font = UIFont.RobotoRegular(size: 14)
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.RobotoRegular(size: 14)
        label.text = "0/60"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont.robotoBold(size: 16)
         label.text = "Description"
         label.textColor = .white
         label.textAlignment = .left
         return label
    }()
    
    private lazy var descriptionTextView: DescriptionInputTextField = {
        let tv = DescriptionInputTextField()
        tv.placeHolderText = "Let people know about this Post"
        tv.font = UIFont.RobotoRegular(size: 14)
        tv.textColor = .white
        tv.backgroundColor = .clear
        return tv
    }()
    
    let scrollView = UIScrollView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barTintColor = .clear
        configureUI()
//        configureScrollView()
    }
    
    //MARK: - Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDone() {
        guard let image = selectedImage else { return }
        guard let title = TitleTextView.text else { return }
        guard let description = descriptionTextView.text else { return }
        guard let user = currentUser else { return }
        
        showLoader(true)
        PostService.uploadPost(image: image, title: title, description: description, user: user) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Failed to upload post with errror \(error.localizedDescription)")
                return
            }
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
    
    //MARK: - Helpers
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 60 {
            textView.deleteBackward()
        }
    }
    
//    func configureScrollView() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//        scrollView.centerX(inView: view)
//        scrollView.anchor(top: view.topAnchor, bottom: view.bottomAnchor)
//    }
    
    func configureUI() {
        view.backgroundColor = .spaceColor
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapDone))
        
        //PhotoImageView
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 320, width: 250)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 25)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 14
        
        //TitleLabel
        view.addSubview(titleLabel)
        titleLabel.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, paddingTop: 45, paddingLeft: 40)
        
        //TitleTextView
        view.addSubview(TitleTextView)
        TitleTextView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 40, paddingRight: 40, height: 50)
        
        //CharacterCountLabel
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: TitleTextView.bottomAnchor, right: view.rightAnchor, paddingRight: 40)
        
        //DescriptionLabel
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: TitleTextView.bottomAnchor, left: view.leftAnchor, paddingTop: 25, paddingLeft: 40)
        
        //DescriptionTextView
        view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 40, paddingRight: 40, height: 150)
    }
}

    //MARK: - UITextViewDelegate

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/60"
    }
}
