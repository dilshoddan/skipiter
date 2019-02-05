//
//  SearchUserView.swift
//  Skipiter
//
//  Created by Admin on 2/5/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia

class SearchUserView: UIView {

    public var shouldSetupConstraints = true
    public var usersTable: UITableView!
    
    public var search: UISearchController!
    
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
            self.sv([usersTable, activityIndicator])
            
            
            usersTable.top(2%).height(98%).width(100%)
            
            activityIndicator.fillContainer()
            
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        usersTable = UITableView()
        
        search = UISearchController()
//        searchButton.setBackgroundImage(UIImage(named: "Search_S")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }

}
