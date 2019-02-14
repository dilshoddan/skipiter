//
//  CommentOfSkipViewController.swift
//  Skipiter
//
//  Created by Home on 2/13/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Hero
import Stevia
import PromiseKit

class CommentsViewController: UIViewController {
    
    public var commentsView: CommentsView!
    public var comments: [AlamofireWorker.CommentForm] = [AlamofireWorker.CommentForm] ()
    public var skip: AlamofireWorker.listAllSkipsJsonData?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        navigationController?.isNavigationBarHidden = false
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetDBDefaults()
        AddTapGestures()
        ListCommentsOfSkip()
        
        //test data
        
    }
    
    @objc private func RefreshComments(_ sender: Any) {
        ListCommentsOfSkip()
        self.refreshControl.endRefreshing()
        self.commentsView.activityIndicator.stopAnimating()
    }
    
    
    func render(){
        view.sv(commentsView)
        commentsView.height(100%).width(100%).centerInContainer()
    }
    func SetControlDefaults(){
        
        commentsView = CommentsView(frame: view.bounds)
        commentsView.backgroundColor = .white
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            commentsView.commentsTable.refreshControl = refreshControl
        } else {
            commentsView.commentsTable.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(RefreshComments(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.36, green:0.53, blue:0.66, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
        
    }
    
    func ListCommentsOfSkip(){
        guard let skip = skip else {
            return
        }
        
        commentsView.activityIndicator.isHidden = false
        commentsView.activityIndicator.startAnimating()
        
        
        comments.append(AlamofireWorker.CommentForm(id: 1,
                                                    text: "Comment1 ~ Let's have a long text to see cell is able to show them all propperly. I doubt but still hope",
                                                    date: "2018",
                                                    userName: "userName",
                                                    skipID: 1))
        
        comments.append(AlamofireWorker.CommentForm(id: 1,
                                                    text: "Comment2 ~ I doubt but still hope",
                                                    date: "2019",
                                                    userName: "userName",
                                                    skipID: 1))
        
        self.commentsView.commentsTable.reloadData()
        
        self.commentsView.commentsTable.rowHeight = UITableView.automaticDimension
        self.commentsView.commentsTable.estimatedRowHeight = 600
        self.commentsView.commentsTable.setNeedsUpdateConstraints()
        self.commentsView.commentsTable.updateConstraintsIfNeeded()
        
        commentsView.commentsTable.register(SkipTableViewCell.self, forCellReuseIdentifier: "Skip")
        commentsView.commentsTable.delegate = self
        commentsView.commentsTable.dataSource = self
        
        AlamofireWorker.GetCommentsOfSkip()
            .done{ tuple in
                
                if tuple.1 {
                    self.comments = AlamofireWorker.ConvertDictionaryToComments(tuple.0)
                    
                    self.commentsView.commentsTable.reloadData()
                    
                    self.commentsView.commentsTable.rowHeight = UITableView.automaticDimension
                    self.commentsView.commentsTable.estimatedRowHeight = 600
                    self.commentsView.commentsTable.setNeedsUpdateConstraints()
                    self.commentsView.commentsTable.updateConstraintsIfNeeded()
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: "Cannot connect to Internet", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        print("Cannot connect to Internet")
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                self.commentsView.activityIndicator.stopAnimating()
                self.commentsView.activityIndicator.isHidden = true
                self.commentsView.activityIndicator.removeFromSuperview()
                
            }
            .catch { error in
                print(error.localizedDescription)
                
        }
        
        commentsView.commentsTable.estimatedRowHeight = 600
        commentsView.commentsTable.rowHeight = UITableView.automaticDimension
        
    }
    
    func AddTapGestures(){
    }
    
    func SetDBDefaults(){
    }
    
    
    
    
    
}

//CHEATING HERE ~ REUSING SKIP CELL FOR A COMMENT SINCE THE FORM IS THE SAME
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Skip", for: indexPath) as! SkipTableViewCell;
        let comment = comments[indexPath.row]
        let skip = AlamofireWorker.listAllSkipsJsonData(date: comment.date, text: comment.text, userName: comment.userName)
        cell.skip = skip
        cell.detailTextLabel?.text = skip.date
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}






