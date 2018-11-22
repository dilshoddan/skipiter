//
//  PasswordResetViewController.swift
//  Skipiter
//
//  Created by Admin on 11/22/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia

class PasswordResetViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let okButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControllerDefaults()
        render()
    }
    
    @objc func OkClicked(){
        navigationController?.popViewController(animated: true)
        
    }
    
    func render(){
        stackView.sv(okButton)
        okButton.height(30%).width(90%).centerVertically().centerHorizontally()
        
        view.sv(stackView)
        stackView.height(30%).width(100%).centerInContainer()
    }
    
    func SetControllerDefaults(){
        
        self.title = "PasswordResetVC"
        view.backgroundColor = LoginColors.PasswordResetVC
        
        stackView.backgroundColor = LoginColors.LoginContent
        
        okButton.backgroundColor = LoginColors.LoginViewVC
        okButton.setTitle("OK", for: .normal)
        okButton.tintColor = .white
        okButton.layer.cornerRadius = 5
        okButton.clipsToBounds = true
        okButton.isEnabled = true
        okButton.isUserInteractionEnabled = true
        okButton.addTarget(self, action: #selector(OkClicked), for: .touchUpInside)
        
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
