//
//  SearchUserViewController.swift
//  Skipiter
//
//  Created by Admin on 1/30/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Hero
import Stevia
import PromiseKit

class SearchUserViewController: UIViewController {

    public var searchUserView: SearchUserView!
    private let refreshControl = UIRefreshControl()
    public var users: [AlamofireWorker.JsonUser] = [AlamofireWorker.JsonUser] ()
    public var filteredUsers: [AlamofireWorker.JsonUser] = [AlamofireWorker.JsonUser] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
//        navigationController?.isNavigationBarHidden = false
//        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        hero.isEnabled = true
        SetControlDefaults()
        render()
        ListAllUsers()
        
    }
    deinit {
        
    }
    
    @objc private func RefreshUsers(_ sender: Any) {
        ListAllUsers()
        self.refreshControl.endRefreshing()
        self.searchUserView.activityIndicator.stopAnimating()
    }
    
    
    func SetControlDefaults(){
        searchUserView = SearchUserView(frame: self.view.bounds)
        
        searchUserView.searchController.searchResultsUpdater = self
        searchUserView.searchController.obscuresBackgroundDuringPresentation = false
        searchUserView.searchController.searchBar.placeholder = "User name"
        navigationItem.searchController = searchUserView.searchController
        definesPresentationContext = true

        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            searchUserView.usersTable.refreshControl = refreshControl
        } else {
            searchUserView.usersTable.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(RefreshUsers(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.36, green:0.53, blue:0.66, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Users ...")
        
    }
    
    func render(){
        
        view.sv(searchUserView)
        searchUserView.height(100%).width(100%).centerInContainer()
        searchUserView.updateConstraints()
        
        
    }
    
    func isFiltering() -> Bool {
        return searchUserView.searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchUserView.searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({( user : AlamofireWorker.JsonUser) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        
        searchUserView.usersTable.reloadData()
    }
    
    
    
    func ListAllUsers(){
        
    }

}


extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count
        if isFiltering() {
            return filteredUsers.count
        }
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Skip", for: indexPath) as! UsersTableViewCell;
        let user: AlamofireWorker.JsonUser
        if isFiltering() {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        cell.user = user
        cell.detailTextLabel?.text = user.email
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
}

extension SearchUserViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}
