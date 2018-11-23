//
//  RegisterViewController.swift
//  Skipiter
//
//  Created by Admin on 11/22/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia

class RegisterViewController: UIViewController {
    
    
    private var registerView: UIView!
    private var firstNameLabel: UILabel!
    private var firstName: UITextField!
    private var lastNameLabel: UILabel!
    private var lastName: UITextField!
    private var emailLabel: UILabel!
    private var email: UITextField!
    private var userNameLabel: UILabel!
    private var userName: UITextField!
    private var userPasswordLabel: UILabel!
    private var userPassword: UITextField!
    private var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControllerDefaults()
        render()
    }
    
    @objc func OkClicked(){
        navigationController?.popViewController(animated: true)
        
    }
    
    func SetControllerDefaults(){
        
        self.title = "RegisterVC"
        view.backgroundColor = LoginColors.RegisterVC
        
        registerView = UIView()
        registerView.backgroundColor = LoginColors.LoginContent
        
        firstNameLabel = UILabel()
        firstNameLabel.text = "First name:"
        firstName = UITextField()
        
        lastNameLabel = UILabel()
        lastNameLabel.text = "Last name:"
        lastName = UITextField()
        
        emailLabel = UILabel()
        emailLabel.text = "Email address:"
        email = UITextField()
        
        userNameLabel = UILabel()
        userNameLabel.text = "User name:"
        userName = UITextField()
        
        userPasswordLabel = UILabel()
        userPasswordLabel.text = "User name:"
        userPassword = UITextField()
        
        
        okButton = UIButton()
        okButton.backgroundColor = LoginColors.LoginViewVC
        okButton.setTitle("OK", for: .normal)
        okButton.tintColor = .white
        okButton.layer.cornerRadius = 5
        okButton.clipsToBounds = true
        okButton.isEnabled = true
        okButton.isUserInteractionEnabled = true
        okButton.addTarget(self, action: #selector(OkClicked), for: .touchUpInside)
    }
    
    func render(){
        registerView.sv([firstNameLabel, firstName, lastNameLabel, lastName, emailLabel, email, userNameLabel, userName, userPasswordLabel, userPassword, okButton])
        view.sv(registerView)
        registerView.height(100%).width(100%).centerInContainer()
        
        let heightConstant = CGFloat(20)
        let leftOffset = CGFloat(20)
        
        for label in [firstNameLabel, lastNameLabel, emailLabel, userNameLabel, userPasswordLabel] {
            label?.height(heightConstant).width(100%)
        }
        
        for textField in [firstName, lastName, email, userName, userPassword] {
            textField?.height(heightConstant + 10).width(100%)
        }
        
        okButton.height(heightConstant).width(70%).left(leftOffset)
        registerView.layout(
            13,
            |-firstNameLabel-|,
            3,
            |-firstName-|,
            13,
            |-lastNameLabel-|,
            3,
            |-lastName-|,
            13,
            |-emailLabel-|,
            3,
            |-email-|,
            13,
            |-userNameLabel-|,
            3,
            |-userName-|,
            13,
            |-userPasswordLabel-|,
            3,
            |-userPassword-|,
            13,
            |-okButton-|
        )
        
        
    }
    
    
    
}
