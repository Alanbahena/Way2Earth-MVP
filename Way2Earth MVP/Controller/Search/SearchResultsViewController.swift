//
//  SearchResultsViewController.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/5/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    
    //MARK: - Properties
    
 
    
    var users = [User]()
    var filteredUsers = [User]()
    

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        view.backgroundColor = .black
        tableView.register(SearchRestulsCell.self, forCellReuseIdentifier: searchResutlsCellIdentifier)
        tableView.rowHeight = 64
    }
}

    //MARK: - UItableViewDataSource

extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchResutlsCellIdentifier, for: indexPath) as! SearchRestulsCell
        let user = filteredUsers[indexPath.row]
        cell.viewModel = SearchResultsCellViewModel(user: user)
        return cell
    }
}

    //MARK: - UITableViewDelegate

extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = filteredUsers[indexPath.row]
        let controller = ProfileController(user: user)
        self.presentingViewController?.navigationController?.pushViewController(controller, animated: false)
    }
}
