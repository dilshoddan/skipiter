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
    
    public var composeImage: UIImageView!
    
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
            self.sv([skipsTable, composeImage, activityIndicator])
            
            
            skipsTable.top(2%).height(98%).width(100%)
            
            activityIndicator.fillContainer()
            composeImage.height(7%).width(11%).right(5%).bottom(15%)
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        skipsTable = UITableView()
        
        composeImage = UIImageView()
        composeImage.image = UIImage(named: "Compose_S")
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }

}
