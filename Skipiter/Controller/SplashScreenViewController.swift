//
//  SplashScreenViewController.swift
//  Skipiter
//
//  Created by Admin on 1/25/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia
import Hero

class SplashScreenViewController: UIViewController {

    public var splashView: SplashView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        SetControlDefaults()
        render()
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        
        ShowSplashScreen()
    }
    
    func ShowSplashScreen(){
        
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        
        let loginVC = LoginViewController()
//        navigationController?.hero.navigationAnimationType = .zoom
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.navigationController?.pushViewController(loginVC, animated: true)
        })
    
        
        
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
