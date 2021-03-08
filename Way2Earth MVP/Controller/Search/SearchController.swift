//
//  SearchController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 2/7/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.

import UIKit

class SearchController: UIViewController, UISearchResultsUpdating {
   
    //MARK: - Properties
    
    var categories: [Categorie]?
    
    let searchController: UISearchController = {
       let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Search"
        vc.searchBar.tintColor = .white
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .spaceColor
        navigationController?.navigationBar.barStyle = .black
        
        fetchCategories()
        configureSearchController()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: searchIdentifier)
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
    }
    
    //MARK: - Helpers
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func fetchCategories() {
        self.categories = Categorie.fetchCategories()
    }
    
    //MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text?.lowercased() else { return }
        
        resultsController.filteredUsers = resultsController.users.filter({ $0.userName.contains(query) || $0.fullName.lowercased().contains(query)})
        
        resultsController.tableView.reloadData()
        
        
     
        
    }
    
    
}

    //MARK: - UICOllectionViewDataSource

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchIdentifier, for: indexPath) as! SearchCollectionViewCell
        cell.categorie = self.categories?[indexPath.item]
        return cell
    }
}

    //MARK: - UICollectionViewDelegateFLowLayout

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 22.5, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
}
