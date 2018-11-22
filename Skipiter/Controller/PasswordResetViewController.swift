//
//  PasswordResetViewController.swift
//  Skipiter
//
//  Created by Admin on 11/22/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class PasswordResetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControllerDefaults()
    }
    
    func SetControllerDefaults(){
        
        self.title = "PasswordResetVC"
        view.backgroundColor = LoginColors.PasswordResetVC
        
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
