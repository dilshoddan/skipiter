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
        
        
        SetControlDefaults()
        render()
        hero.isEnabled = true
        SetDBDefaults()
        AddTapGestures()
        ListCommentsOfSkip()
        
        
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        //test data
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        ListCommentsOfSkip()
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let commentViewBottomY = self.commentsView.commentView.frame.origin.y + self.commentsView.commentView.frame.size.height
            if commentViewBottomY > keyboardSize.origin.y {
                self.commentsView.commentView.frame.origin.y = self.commentsView.commentView.frame.origin.y - (commentViewBottomY - keyboardSize.origin.y)
            }
            else{
                render()
                commentsView.updateConstraints()
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.commentsView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        self.view.endEditing(true)
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
        
        if let skip = skip {
            commentsView.userName.text = skip.userName
            commentsView.userSkip.text = skip.text
            commentsView.userSkipDate.text = skip.date
        }
        
        commentsView.addComment.addTarget(self, action: #selector(AddComment), for: .touchUpInside)
        
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
    
    @objc
    func AddComment(){
        let comment = commentsView.commentField.text
        if let comment = comment,
            let skip = skip,
            !(comment.isEmpty)
        {
            self.view.endEditing(true)
            commentsView.activityIndicator.isHidden = false
            commentsView.activityIndicator.startAnimating()
            
            
            self.commentsView.commentsTable.reloadData()
            
            self.commentsView.commentsTable.rowHeight = UITableView.automaticDimension
            self.commentsView.commentsTable.estimatedRowHeight = 600
            self.commentsView.commentsTable.setNeedsUpdateConstraints()
            self.commentsView.commentsTable.updateConstraintsIfNeeded()
            
            commentsView.commentsTable.register(SkipTableViewCell.self, forCellReuseIdentifier: "Skip")
            commentsView.commentsTable.delegate = self
            commentsView.commentsTable.dataSource = self
            
            AlamofireWorker.AddComment(text: comment, withSkipID: skip.id)
                .done{ sent -> Void in
                    if sent {
                        self.ListCommentsOfSkip()
                        self.commentsView.commentField.text = ""
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Sorry, Connection issues", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Sorry, Connection issues")
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
    }
    
    func ListCommentsOfSkip(){
        guard let skip = skip else {
            return
        }
        
        commentsView.activityIndicator.isHidden = false
        commentsView.activityIndicator.startAnimating()
        
        
        self.commentsView.commentsTable.reloadData()
        
        self.commentsView.commentsTable.rowHeight = UITableView.automaticDimension
        self.commentsView.commentsTable.estimatedRowHeight = 600
        self.commentsView.commentsTable.setNeedsUpdateConstraints()
        self.commentsView.commentsTable.updateConstraintsIfNeeded()
        
        commentsView.commentsTable.register(SkipTableViewCell.self, forCellReuseIdentifier: "Skip")
        commentsView.commentsTable.delegate = self
        commentsView.commentsTable.dataSource = self
        
        AlamofireWorker.GetCommentsOfSkip(skip.id)
            .done{ tuple in
                
                if tuple.1 {
                    self.comments = AlamofireWorker.ConvertDictionaryToComments(tuple.0)
                    if self.comments.count == 0 {
                        self.comments.append(AlamofireWorker.CommentForm(id: 1,
                                                                    text: "Comment1 ~ Let's have a long text to see cell is able to show them all propperly. I doubt but still hope",
                                                                    date: "2018",
                                                                    userName: "userName",
                                                                    skipID: 1))
                        
                        self.comments.append(AlamofireWorker.CommentForm(id: 2,
                                                                    text: "Comment2 ~ I doubt but still hope",
                                                                    date: "2019",
                                                                    userName: "userName",
                                                                    skipID: 1))
                    }
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
        let skip = AlamofireWorker.listAllSkipsJsonData(id: comment.id,
                                                        date: comment.date,
                                                        text: comment.text,
                                                        userName: comment.userName)
        cell.skip = skip
        cell.detailTextLabel?.text = skip.date
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}






