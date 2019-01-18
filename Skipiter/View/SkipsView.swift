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
    public var segmentedControl: UISegmentedControl!
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
            self.sv([skipsTable, segmentedControl, activityIndicator])
            
            skipsTable.top(1%).height(99%).width(100%).centerVertically().centerHorizontally()
            
            segmentedControl.height(5%).width(90%).centerHorizontally()
            segmentedControl.Bottom == self.Bottom
            activityIndicator.fillContainer()
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        segmentedControl = UISegmentedControl()
        segmentedControl = UISegmentedControl(items: ["Skips", "Profile", "Comments", "LogOut"])
        segmentedControl.tintColor = ColorConstants.LoginViewVC
        
        skipsTable = UITableView()
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }

}
