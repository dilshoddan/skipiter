//
//  LaunchScreen.swift
//  Skipiter
//
//  Created by Admin on 1/25/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia


class LaunchScreen: UIView {

    public var shouldSetupConstraints = true
    public var containerView: UIView!
    public var iconImage: UIImageView!
    
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
            
            containerView.sv([iconImage])
            iconImage.height(40%).width(40%).centerHorizontally().centerVertically()
            
            self.sv(containerView)
            containerView.fillContainer()
            
           
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = ColorConstants.LoginViewVC
        
        containerView = UIView()
        containerView.backgroundColor = ColorConstants.LoginContent
        
        iconImage = UIImageView()
            
        
        
        
    }

}
