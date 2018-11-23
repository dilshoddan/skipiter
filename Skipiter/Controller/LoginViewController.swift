//
//  ViewController.swift
//  Skipiter
//
//  Created by Home on 11/19/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia
import Hero

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var keyboardHeight = CGFloat(0.0)
    
    //Controls
    private var loginView: UIView!
    private var loginSubView: UIStackView!
    private var userName: UITextField!
    private var userPassword: UITextField!
    private var loginButton: UIButton!
    private var registerLabel: UILabel!
    private var forgotPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetControlDefaults()
        render(0.0)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification,object: nil)
        
        AddTapGestures()
        hero.isEnabled = true
        self.userName.delegate = self
        self.userPassword.delegate = self
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        self.view.endEditing(true)
        //        return false
        textField.resignFirstResponder()
        return true;
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let loginViewBottomY = self.loginView.frame.origin.y + self.loginView.frame.size.height + 20
            if loginViewBottomY > keyboardSize.origin.y {
                self.loginView.frame.origin.y = self.loginView.frame.origin.y - (loginViewBottomY - keyboardSize.origin.y)
            }
            else{
                render(0.0)
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.loginView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let loginViewBottomY = self.loginView.frame.origin.y + self.loginView.frame.size.height + 20
//            if loginViewBottomY > keyboardSize.origin.y {
//                self.loginView.frame.origin.y = self.loginView.frame.origin.y - (loginViewBottomY - keyboardSize.origin.y)
//            }
//        }
//        UIView.animate(withDuration: 0.2, animations: { () -> Void in
//            self.loginView.layoutIfNeeded()
//            self.view.layoutIfNeeded()
//        })
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        render(0.0)
//        UIView.animate(withDuration: 0.2, animations: { () -> Void in
//            self.loginView.layoutIfNeeded()
//            self.view.layoutIfNeeded()
//        })
//    }
    
    @objc func LoginClicked(){
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    @objc func RegisterLabelTapped(recognizer:UITapGestureRecognizer){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    @objc func ForgotPasswordTapped(recognizer:UITapGestureRecognizer){
        let passwordResetVC = PasswordResetViewController()
        navigationController?.pushViewController(passwordResetVC, animated: true)
        
    }
    
    func SetControlDefaults(){
        
        
        self.title = "LoginVC"
        view.backgroundColor = ColorConstants.LoginViewVC
        
        loginView = UIView()
        loginView.backgroundColor = ColorConstants.LoginContent
        
        loginSubView = UIStackView()
        
        userName = UITextField()
        userName.backgroundColor = .white
        userName.borderStyle = .roundedRect
        userName.isEnabled = true
        userName.isUserInteractionEnabled = true
        
        userPassword = UITextField()
        userPassword.backgroundColor = .white
        userPassword.isSecureTextEntry = true
        userPassword.borderStyle = .roundedRect
        userPassword.isEnabled = true
        userPassword.isUserInteractionEnabled = true
        
        loginButton = UIButton()
        loginButton.backgroundColor = ColorConstants.LoginViewVC
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        loginButton.isEnabled = true
        loginButton.isUserInteractionEnabled = true
        loginButton.addTarget(self, action: #selector(LoginClicked), for: .touchUpInside)
        
        registerLabel = UILabel()
        registerLabel.textColor = ColorConstants.LoginText
        registerLabel.text = "Register"
        
        forgotPasswordLabel = UILabel()
        forgotPasswordLabel.textColor = ColorConstants.LoginText
        forgotPasswordLabel.text = "Forgot password?"
        
        
        
    }
    
    func render(_ withKeyboardHeight: CGFloat){
        let height = CGFloat(25.0)
        let buttonHeight = CGFloat(height + 5)
        
        //Render loginSubView view
        loginSubView.sv([registerLabel, forgotPasswordLabel])
        registerLabel.Left == loginSubView.Left
        forgotPasswordLabel.Right == loginSubView.Right
        
        //Render loginView
        view.sv(loginView)
        loginView.sv(loginSubView)
        loginView.sv([userName, userPassword, loginButton, loginSubView])
        
        
        userName.height(height)
        userPassword.height(height)
        loginButton.height(buttonHeight)
        loginSubView.height(height)
        
        loginView.height((3*height + buttonHeight) + (4*13)).width(100%)
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
            16,
            |-loginButton-|,
            13,
            |-loginSubView-|
        )
        if withKeyboardHeight > 0 {
            loginView.bottom(withKeyboardHeight)
        }
    }
    
    func AddTapGestures(){
        registerLabel.isEnabled = true
        registerLabel.isUserInteractionEnabled = true
        let registerLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterLabelTapped(recognizer:)))
        registerLabel.addGestureRecognizer(registerLabelTapGesture)
        
        
        forgotPasswordLabel.isEnabled = true
        forgotPasswordLabel.isUserInteractionEnabled = true
        let forgotPasswordLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordTapped(recognizer:)))
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordLabelTapGesture)
        
    }
    
    
}

