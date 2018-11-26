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
    public var bannerImage: UIImageView!
    public var profileImage: UIImageView!
    public var segmentedControl: UISegmentedControl!
    public var logOutButton: UIButton!
    
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
            self.sv([bannerImage, profileImage, segmentedControl, logOutButton])
            
            bannerImage.height(24%).width(100%).centerHorizontally()
            bannerImage.Top == self.Top
            
            profileImage.height(18%).width(30%).left(15)
            profileImage.CenterY == bannerImage.Bottom
            
            segmentedControl.height(5%).width(90%).centerHorizontally()
            segmentedControl.Bottom == self.Bottom
            
            logOutButton.height(5%).width(20%)
            logOutButton.Bottom == bannerImage.Bottom
            logOutButton.Right == bannerImage.Right
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = .white
        
        bannerImage = UIImageView()
        bannerImage.backgroundColor = ColorConstants.ProfileVC
        
        profileImage = UIImageView()
        profileImage.backgroundColor = ColorConstants.ProfileVC
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.cornerRadius = 5.0
        
        segmentedControl = UISegmentedControl()
        segmentedControl = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
        segmentedControl.tintColor = ColorConstants.LoginViewVC
        
        logOutButton = UIButton()
        logOutButton.backgroundColor = ColorConstants.LoginViewVC
        logOutButton.tintColor = ColorConstants.LoginViewVC
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.layer.cornerRadius = 5
        logOutButton.clipsToBounds = true
        logOutButton.isEnabled = true
        logOutButton.isUserInteractionEnabled = true
        logOutButton.setTitle("Out", for: .normal)
        
        
    }
    
    
}


