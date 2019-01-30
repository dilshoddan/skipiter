//
//  ComposeViewController.swift
//  Skipiter
//
//  Created by Admin on 1/30/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia
import Hero

class ComposeViewController: UIViewController {

    public var composeView: ComposeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Compose"
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        SetControlDefaults()
        render()
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        
    }
    
    deinit {
       
    }
    
    func SetControlDefaults(){
        
        composeView = ComposeView(frame: self.view.bounds)
        
    }
    
    func render(){
        
        view.sv(composeView)
        composeView.height(100%).width(100%).centerInContainer()
        composeView.updateConstraints()
    }
}
