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
    public var skipView: UIView!
    
    public var commentView: UIView!
    public var commentField: UITextField!
    public var addComment: UIButton!
    
    public var activityIndicator: UIActivityIndicatorView!
    
    let screenSize = UIScreen.main.bounds
    
    
    private let profileImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "l2")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 1.0
        img.layer.cornerRadius = 25.0
        
        return img
    }()
    
    public let userName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    public let userSkip : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    public let userSkipDate : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
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
            
            skipView.sv([profileImage, userName, userSkipDate, userSkip])
            userName.top(3)
            
            profileImage.size(50).left(5%)
            profileImage.Right == userName.Left - 5
            
            
            userName.Left == userSkip.Left
            userSkipDate.right(5%)
            align(tops: [profileImage, userName, userSkipDate])
            
            userSkip.Top == userName.Bottom
            userSkip.Left == userName.Left
            userSkip.right(5%)
            
            commentView.sv([commentField, addComment])
            commentView.layout(
                0,
                |-commentField-addComment-|,
                5
            )
            commentField.width(74%)
            addComment.width(24%)
            commentField.left(2%).right(1%)
            
                //.left(2%).right(2%)
            
            self.sv([skipView, commentsTable, commentView, activityIndicator])
            
            skipView.top(2%).height(10%).width(100%)
            skipView.Bottom == commentsTable.Top
            
            commentsTable.height(76%).width(90%)
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
        
        skipView = UIView()
        
        commentsTable = UITableView()
        
        commentView = UIView()
        commentView.backgroundColor = .white
        
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

