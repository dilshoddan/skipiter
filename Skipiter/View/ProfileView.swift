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
    
    var shouldSetupConstraints = true
    var bannerImage: UIImageView!
    var profileImage: UIImageView!
    var segmentedControl: UISegmentedControl!
    var logOutButton: UIButton!
    
    let screenSize = UIScreen.main.bounds
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        SetControlDefaults()
        
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
    
    override func updateConstraints(){
        if(shouldSetupConstraints){
            
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        
        
    }
    
    
}


