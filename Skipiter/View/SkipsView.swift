//
//  ProfileSkipsView.swift
//  Skipiter
//
//  Created by Admin on 1/12/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia

class SkipsView: UIView {

    public var shouldSetupConstraints = true
    public var skipsTable: UITableView!
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
            self.sv([skipsTable, activityIndicator])
            
            skipsTable.top(2%).height(98%).width(100%)
            activityIndicator.fillContainer()
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        skipsTable = UITableView()
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }

}
