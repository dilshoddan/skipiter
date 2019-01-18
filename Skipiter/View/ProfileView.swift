//
//  ProfileView.swift
//  FakeTwitter
//
//  Created by Home on 11/15/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia

class ProfileView: UIView {
    
    public var shouldSetupConstraints = true
    public var skipsTable: UITableView!
    public var profileBanner: UIImageView!
    public var profileImage: UIImageView!
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
            self.sv([skipsTable, profileBanner, profileImage, segmentedControl, activityIndicator])
            
            profileBanner.height(16%).width(100%).centerHorizontally()
            profileBanner.Top == self.Top
            
            profileImage.height(10%).width(18%).left(15)
            profileImage.CenterY == profileBanner.Bottom
            
            skipsTable.top(2%).height(72%).width(100%)
            skipsTable.Top == profileImage.Bottom
            
            segmentedControl.height(5%).width(90%).centerHorizontally()
            segmentedControl.Bottom == self.Bottom
            
            activityIndicator.fillContainer()
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        skipsTable = UITableView()
        
        profileBanner = UIImageView()
        profileBanner.backgroundColor = ColorConstants.ProfileVC
        
        profileImage = UIImageView()
        profileImage.backgroundColor = ColorConstants.ProfileVC
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.cornerRadius = 5.0
        
        segmentedControl = UISegmentedControl()
        segmentedControl = UISegmentedControl(items: ["Skips", "Profile", "Comments", "LogOut"])
        segmentedControl.tintColor = ColorConstants.LoginViewVC
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }
    
    
}


