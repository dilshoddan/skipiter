//
//  ViewController.swift
//  Skipiter
//
//  Created by Home on 11/19/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia

class LoginViewController: UIViewController {
    
    var keyboardHeight = CGFloat(0.0)
    
    //Controls
    private let loginView = UIView()
    private let loginSubView = UIStackView()
    private let userName = UITextField()
    private let userPassword = UITextField()
    private let loginButton = UIButton()
    private let registerLabel = UILabel()
    private let forgotPasswordLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetControlDefaults()
        render(0.0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let loginViewBottomY = self.loginView.frame.origin.y + self.loginView.frame.size.height + 40
            if loginViewBottomY > keyboardSize.origin.y {
                self.loginView.frame.origin.y = self.loginView.frame.origin.y - (loginViewBottomY - keyboardSize.origin.y)
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.loginView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        render(0.0)
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.loginView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func LoginClicked(){
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    @objc func RegisterClicked(){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    @objc func ForgotPasswordClicked(){
        let passwordResetVC = PasswordResetViewController()
        navigationController?.pushViewController(passwordResetVC, animated: true)
        
    }
    
    func render(_ withKeyboardHeight: CGFloat){
        
        //Render loginSubView view
        loginSubView.sv([registerLabel, forgotPasswordLabel])
        registerLabel.Left == loginSubView.Left
        forgotPasswordLabel.Right == loginSubView.Right
        
        //Render loginView
        view.sv(loginView)
        loginView.sv(loginSubView)
        loginView.sv([userName, userPassword, loginButton, loginSubView])
        
        let heightConstant = CGFloat(25.0)
        userName.height(heightConstant)
        userPassword.height(heightConstant)
        loginButton.height(heightConstant)
        loginSubView.height(heightConstant)
        
        loginView.height((4*heightConstant) + (4*13)).width(100%)
        loginView.centerInContainer()
        
        userName.width(90%).centerHorizontally()
        userPassword.width(90%).centerHorizontally()
        loginButton.width(90%).centerHorizontally()
        loginSubView.width(90%).centerHorizontally()
        
        
        loginView.layout(
            13,
            |-userName-|,
            13,
            |-userPassword-|,
            13,
            |-loginButton-|,
            13,
            |-loginSubView-|
        )
        if withKeyboardHeight > 0 {
            loginView.bottom(withKeyboardHeight)
        }
    }
    
    func SetControlDefaults(){
        
        
        self.title = "LoginVC"
        view.backgroundColor = LoginColors.LoginViewVC
        loginView.backgroundColor = LoginColors.LoginContent
        
        userName.backgroundColor = .white
        userName.borderStyle = .roundedRect
        userName.isEnabled = true
        userName.isUserInteractionEnabled = true
        
        userPassword.backgroundColor = .white
        userPassword.isSecureTextEntry = true
        userPassword.borderStyle = .roundedRect
        userPassword.isEnabled = true
        userPassword.isUserInteractionEnabled = true
        
        loginButton.backgroundColor = LoginColors.LoginViewVC
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        loginButton.isEnabled = true
        loginButton.isUserInteractionEnabled = true
        loginButton.addTarget(self, action: #selector(LoginClicked), for: .touchUpInside)
        
        registerLabel.textColor = LoginColors.LoginText
        registerLabel.text = "Register"
        
        
        forgotPasswordLabel.textColor = LoginColors.LoginText
        forgotPasswordLabel.text = "Forgot password?"
        
        
    }
    
    
}

