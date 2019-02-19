//
//  CommentsOfSkipView.swift
//  Skipiter
//
//  Created by Home on 2/13/19.
//  Copyright © 2019 Home. All rights reserved.
//


import UIKit
import Stevia

class CommentsView: UIView {
    
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
            commentView.layout(
                0,
                |-commentField-addComment-|,
                10
            )
            commentField.width(74%)
            addComment.width(20%)
            commentField.left(2%).right(2%)
            
                //.left(2%).right(2%)
            
            self.sv([commentsTable, commentView])
            
            
            
            commentsTable.top(2%).height(86%).width(90%)
            commentsTable.Bottom == self.Bottom
            commentsTable.left(10%)


            commentView.Bottom == self.Bottom
            commentView.width(100%)
//            commentView.bottom(2%)
            
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
        addComment.setTitle("Add", for: .normal)
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

