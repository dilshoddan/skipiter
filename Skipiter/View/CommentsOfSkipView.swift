//
//  CommentsOfSkipView.swift
//  Skipiter
//
//  Created by Home on 2/13/19.
//  Copyright © 2019 Home. All rights reserved.
//


import UIKit
import Stevia

class CommentsOfSkipView: UIView {
    
    public var shouldSetupConstraints = true
    public var commentsTable: UITableView!
    public var commentView: UIView!
    public var commentField: UITextField!
    public var addComment: UIButton!
    
    public var activityIndicator: UIActivityIndicatorView!
    
    let screenSize = UIScreen.main.bounds
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        shouldSetupConstraints = true
        SetControlDefaults()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
    override func updateConstraints(){
        if(shouldSetupConstraints){
            commentView.sv([commentField, addComment])
            commentField.width(80%)
            commentField.Left == self.Left
            commentField.Right == addComment.Left
            addComment.width(20%)
            
            self.sv([commentsTable, commentView, activityIndicator])
            
            commentsTable.top(2%).height(86%).width(100%)
            
            commentView.top(2%).height(10%).width(100%)
            commentView.Bottom == self.Bottom
            
            activityIndicator.fillContainer()
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        commentsTable = UITableView()
        
        commentView = UIView()
        
        commentField = UITextField()
        commentField.backgroundColor = .white
        commentField.borderStyle = .roundedRect
        commentField.isEnabled = true
        commentField.isUserInteractionEnabled = true
        commentField.autocorrectionType = .no
        commentField.autocapitalizationType = .none
        commentField.spellCheckingType = .yes
        
        addComment = UIButton()
        addComment.backgroundColor = ColorConstants.LoginViewVC
        addComment.setTitle("Login", for: .normal)
        addComment.tintColor = .white
        addComment.layer.cornerRadius = 5
        addComment.clipsToBounds = true
        addComment.isEnabled = true
        addComment.isUserInteractionEnabled = true
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }
    
}

