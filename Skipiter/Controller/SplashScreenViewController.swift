//
//  SplashScreenViewController.swift
//  Skipiter
//
//  Created by Admin on 1/25/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia

class SplashScreenViewController: UIViewController {

    public var splashView: SplashView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetControlDefaults()
        render()
        hero.isEnabled = true
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func SetControlDefaults(){
        self.title = "Splash Screen"
        
        splashView = SplashView(frame: self.view.bounds)
    }
    
    func render(){
        
        view.sv(splashView)
        splashView.height(100%).width(100%).centerInContainer()
        splashView.updateConstraints()
    }

}
