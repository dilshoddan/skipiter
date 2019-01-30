//
//  ComposeView.swift
//  Skipiter
//
//  Created by Admin on 1/30/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia
import Hero

class ComposeView: UIView {

    public var shouldSetupConstraints = true
    public var composeText: UITextView!
    public var tabBar: UITabBar!
    public var cancelItem: UITabBarItem!
    public var acceptItem: UITabBarItem!
    
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
            self.sv([tabBar, composeText, activityIndicator])
            
//            cancelItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            tabBar.height(10%).width(100%).top(0%)
            composeText.height(98%).width(100%).top(10%)
            activityIndicator.fillContainer()
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        tabBar = UITabBar()
        cancelItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        acceptItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        tabBar.items = [cancelItem, acceptItem]
        
        composeText = UITextView()
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }

}
