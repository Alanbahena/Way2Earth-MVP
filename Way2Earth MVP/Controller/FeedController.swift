//
//  FeedController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//

import UIKit

class FeedController: UICollectionViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = UIColor.spaceColor
    }
}
