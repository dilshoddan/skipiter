//
//  MainNavigationController.swift
//  Skipiter
//
//  Created by Admin on 11/21/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetControllerDefaults()
    }
    

    func SetControllerDefaults(){
        view.backgroundColor = LoginColors.MainNavigation
        self.navigationBar.isHidden = true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
