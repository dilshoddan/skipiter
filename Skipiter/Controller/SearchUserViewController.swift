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

class SearchUserViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {

    public var searchUserView: SearchUserView!
    private var searchController: UISearchController!
    private let refreshControl = UIRefreshControl()
    public var users: [AlamofireWorker.JsonUser] = [AlamofireWorker.JsonUser] ()
    public var filteredUsers: [AlamofireWorker.JsonUser] = [AlamofireWorker.JsonUser] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        hero.isEnabled = true
        SetControlDefaults()
        render()
        ListAllUsers()
        
        navigationController?.isNavigationBarHidden = true
        
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        navigationController?.isNavigationBarHidden = true
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
        
        searchController = UISearchController(searchResultsController: nil)
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "User Name Here"
        searchController.searchBar.isHidden = false
        searchController.searchBar.tintColor = .black
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.isUserInteractionEnabled  = true
//        navigationController?.navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self

        searchUserView.usersTable.tableHeaderView = searchController.searchBar
        
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
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let urlString = searchBar.text
////        if let urlString = urlString {
////            RedirectTo(urlString)
////        }
////
//        searchBar.resignFirstResponder()
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({( user : AlamofireWorker.JsonUser) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        
        searchUserView.usersTable.reloadData()
    }
    
    
    
    func ListAllUsers(){
        searchUserView.activityIndicator.isHidden = false
        searchUserView.activityIndicator.startAnimating()
        
        
        users.append(AlamofireWorker.JsonUser(name: "DoctorStrange", email: "doctor@strange.place"))
        users.append(AlamofireWorker.JsonUser(name: "RealDoctor", email: "doctor@hospital.bed"))
        self.searchUserView.usersTable.reloadData()
        
        searchUserView.usersTable.rowHeight = UITableView.automaticDimension
        searchUserView.usersTable.estimatedRowHeight = 600
        searchUserView.usersTable.setNeedsUpdateConstraints()
        searchUserView.usersTable.updateConstraintsIfNeeded()
        
        searchUserView.usersTable.register(UsersTableViewCell.self, forCellReuseIdentifier: "User")
        searchUserView.usersTable.delegate = self
        searchUserView.usersTable.dataSource = self
        
        AlamofireWorker.ListAllUsers()
            .done{ tuple in
                
                if tuple.1 {
                    self.users = AlamofireWorker.ConvertDictionaryToUsers(tuple.0)
                    
                    self.searchUserView.usersTable.reloadData()
                    
                    self.searchUserView.usersTable.rowHeight = UITableView.automaticDimension
                    self.searchUserView.usersTable.estimatedRowHeight = 600
                    self.searchUserView.usersTable.setNeedsUpdateConstraints()
                    self.searchUserView.usersTable.updateConstraintsIfNeeded()
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: "Cannot connect to Internet", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        print("Cannot connect to Internet")
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                self.searchUserView.activityIndicator.stopAnimating()
                self.searchUserView.activityIndicator.isHidden = true
                self.searchUserView.activityIndicator.removeFromSuperview()
                
            }
            .catch { error in
                print(error.localizedDescription)
                
        }
        
        searchUserView.usersTable.estimatedRowHeight = 600
        searchUserView.usersTable.rowHeight = UITableView.automaticDimension
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath) as! UsersTableViewCell;
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

