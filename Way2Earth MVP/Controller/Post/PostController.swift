//
//  PostController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/16/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import AVFoundation

protocol PostLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, sizeForSectionImageHeaderViewForSection section: Int) -> CGFloat
    func collectionView(collectionView: UICollectionView, sizeForSectionAnnotationHeaderViewForSection section: Int) -> CGFloat
}

class PostController: UICollectionViewController {
    
    //MARK: - Properties
    
    private var posts = [Post]() {
        didSet{ collectionView.reloadData() }
    }
    var post: Post?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setTitleViewNavigationBar()
        setRightNavigationButton()
        fetchPosts()
        checkIfUserLikedPosts()
    }
    
    //MARK: - API
    
    func fetchPosts() {
        guard let post = post else { return }
        PostService.fetchPosts(forUser: post.ownerUid) { posts in
            self.posts = posts
        }
    }
    
    func checkIfUserLikedPosts() {
        if let post = post {
            PostService.checkIfUserLikedPost(post: post) { didLike in
                self.post?.didLike = didLike
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Helpers
    
    func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.spaceColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        collectionView.register(PostHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: postHeaderCellIdentifier)
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: postCellIdentifier)
        
        if let layout = collectionView.collectionViewLayout as? PostLayout {
            layout.delegate = self
        }
    }
    
    func setTitleViewNavigationBar() {
        let title = post?.ownerFullName
        let image = #imageLiteral(resourceName: "profileImage")
        
        setTitle(title!, andImage: image)
    }
    
    func setRightNavigationButton() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Settings"), for: .normal)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    
    //MARK: - UICOllectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if posts.count > 5 {
            return 5
        } else {
            return posts.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellIdentifier, for: indexPath) as! PostCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: postHeaderCellIdentifier, for: indexPath) as! PostHeaderCell
        header.delegate = self
        if let post = post {
            header.viewModel = PostViewModel(post: post)
        }
        
        return header
    }
}

    //MARK: - ProfileLayoutDelegate

extension PostController: PostLayoutDelegate {
    
    //Item
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        
        let url = URL(string: posts[indexPath.item].imageUrl)
        let imageSize = sizeOfImageAt(url: url!)
        let boundingRect = CGRect(x: 0, y: 0, width: withWidth, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: imageSize! , insideRect: boundingRect)

        return rect.size.height
    }
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        //Width of the titleLabel
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
    
    //Header
    func collectionView(collectionView: UICollectionView, sizeForSectionImageHeaderViewForSection section: Int) -> CGFloat {
        
        let imageWidth = view.frame.width - 20 //From the HeaderCell
        let url = URL(string: post!.imageUrl)
        let imageSize = sizeOfImageAt(url: url!)!
        let boundingRect = CGRect(x: 0, y: 0, width: imageWidth, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: imageSize, insideRect: boundingRect)
    
        return rect.size.height
    }
    
    func collectionView(collectionView: UICollectionView, sizeForSectionAnnotationHeaderViewForSection section: Int) -> CGFloat {
        let imageWidth = view.frame.width - 20 //From the HeaderCell
        //TitleText
        let titleText = post?.title
        let font = UIFont.merriWeatherBold(size: 17)
        let titleTextHeight = titleText?.heightForWidth(width: imageWidth, font: font)
        //TimeLabel
        let timeText = "20 hours Ago"
        let timeFont = UIFont.openSansRegular(size: 12)
        let timeTextHeight = timeText.heightForWidth(width: imageWidth, font: timeFont)
        //Description
        let descriptionText = post?.description
        let descriptionFont = UIFont.openSansRegular(size: 13)
        let descriptionHeight = descriptionText?.heightForWidth(width: imageWidth, font: descriptionFont)
        //UserPostsLabel
        let userPostsLabelText = post?.ownerFullName
        let userPostsLabelFont = UIFont.robotoBold(size: 16)
        let userPostsLabelHeight = userPostsLabelText?.heightForWidth(width: imageWidth, font: userPostsLabelFont)
        //TextsHeight
        let annotationheight = titleTextHeight! + timeTextHeight + descriptionHeight! + userPostsLabelHeight!
        //PaddingHeihgts
        let paddingHeights = PostHeaderCell.postImagePadding + PostHeaderCell.buttonsPadding + PostHeaderCell.titlePadding + PostHeaderCell.timePadding + PostHeaderCell.descriptionPadding + PostHeaderCell.userPostLabelPadding
        
        return annotationheight + paddingHeights
    }
}

    //MARK: - UITableViewDelegate

extension PostController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let uid = post?.ownerUid else { return }
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
}

    //MARK: - PostHeaderCellDelegate

extension PostController: postHeaderCellDelegate {
    func cell(_ cell: PostHeaderCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: false)
    }
    
    func cell(_ cell: PostHeaderCell, didLike post: Post) {
        guard let tab = tabBarController as? MainTabController else { return }
        guard let user = tab.user else { return }
        
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.unlikePost(post: post) { _ in
                cell.likesIcon.setImage(#imageLiteral(resourceName: "likeunselected"), for: .normal)
                cell.viewModel?.post.likes = post.likes - 1
            }
        } else {
            PostService.likePost(post: post) { _ in
                cell.likesIcon.setImage(#imageLiteral(resourceName: "LikesIcon"), for: .normal)
                cell.viewModel?.post.likes = post.likes + 1
                
                NotificationService.uploadNotification(toUid: post.ownerUid, fromUser: user, type: .like, post: post)
            }
        }
    }
}

//MARK: - URLSizeOfImage

extension PostController {

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
