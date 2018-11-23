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
        
        firstNameLabel = UILabel()
        firstNameLabel.text = "First name:"
        firstName = UITextField()
        firstName.backgroundColor = .white
        firstName.borderStyle = .roundedRect
        firstName.isEnabled = true
        firstName.isUserInteractionEnabled = true
        
        lastNameLabel = UILabel()
        lastNameLabel.text = "Last name:"
        lastName = UITextField()
        lastName.backgroundColor = .white
        lastName.borderStyle = .roundedRect
        lastName.isEnabled = true
        lastName.isUserInteractionEnabled = true
        
        emailLabel = UILabel()
        emailLabel.text = "Email address:"
        email = UITextField()
        email.backgroundColor = .white
        email.borderStyle = .roundedRect
        email.isEnabled = true
        email.isUserInteractionEnabled = true
        
        userNameLabel = UILabel()
        userNameLabel.text = "User name:"
        userName = UITextField()
        userName.backgroundColor = .white
        userName.borderStyle = .roundedRect
        userName.isEnabled = true
        userName.isUserInteractionEnabled = true
        
        userPasswordLabel = UILabel()
        userPasswordLabel.text = "User password:"
        userPassword = UITextField()
        userPassword.backgroundColor = .white
        userPassword.isSecureTextEntry = true
        userPassword.borderStyle = .roundedRect
        userPassword.isEnabled = true
        userPassword.isUserInteractionEnabled = true
        
        
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
        view.sv([firstNameLabel, firstName, lastNameLabel, lastName, emailLabel, email, userNameLabel, userName, userPasswordLabel, userPassword, okButton])
        
        let heightConstant = CGFloat(30)
        let leftOffset = CGFloat(10)
        
        for label in [firstNameLabel, lastNameLabel, emailLabel, userNameLabel, userPasswordLabel] {
            label?.height(heightConstant).left(leftOffset)
        }
        
        for textField in [firstName, lastName, email, userName, userPassword] {
            textField?.height(heightConstant).left(leftOffset)
        }
        okButton.height(heightConstant + 15).left(leftOffset)
        
        view.layout(
            (2*heightConstant),
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
