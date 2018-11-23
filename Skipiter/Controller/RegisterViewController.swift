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
    
    private var registerView: UIStackView!
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func OkClicked(){
        navigationController?.popViewController(animated: true)
        
    }
    
    func SetControllerDefaults(){
        
        self.title = "RegisterVC"
        view.backgroundColor = LoginColors.RegisterVC
        
        registerView = UIStackView()
        registerView.backgroundColor = LoginColors.RegisterVC
        
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
        
        registerView.sv([firstNameLabel, firstName, lastNameLabel, lastName, emailLabel, email, userNameLabel, userName, userPasswordLabel, userPassword, okButton])
        view.sv(registerView)
        registerView.height(100%).width(100%)
        
        let heightConstant = CGFloat(30)
        let leftOffset = CGFloat(10)
        
        for label in [firstNameLabel, lastNameLabel, emailLabel, userNameLabel, userPasswordLabel] {
            label?.height(heightConstant).left(leftOffset)
        }
        
        for textField in [firstName, lastName, email, userName, userPassword] {
            textField?.height(heightConstant).left(leftOffset)
        }
        okButton.height(heightConstant + 10).left(leftOffset)
        
        registerView.layout(
            (2*heightConstant),
            |-firstNameLabel-|,
            |-firstName-|,
            13,
            |-lastNameLabel-|,
            |-lastName-|,
            13,
            |-emailLabel-|,
            |-email-|,
            13,
            |-userNameLabel-|,
            |-userName-|,
            13,
            |-userPasswordLabel-|,
            |-userPassword-|,
            23,
            |-okButton-|
        )
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.registerView.frame.size.height > keyboardSize.origin.y {
                self.registerView.frame.origin.y = self.registerView.frame.origin.y - keyboardSize.origin.y
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.registerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        render()
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.registerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    
    
}
