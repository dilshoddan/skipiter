//
//  MainNavigationController.swift
//  Skipiter
//
//  Created by Admin on 11/21/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Hero

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetControllerDefaults()
        hero.isEnabled = true
    }
    

    func SetControllerDefaults(){
        view.backgroundColor = ColorConstants.MainNavigation
        self.navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }

}
