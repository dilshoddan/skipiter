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
    
    //Controls
    private var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetControlDefaults()
        render()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification,object: nil)
        
        AddTapGestures()
        hero.isEnabled = true
        loginView.userName.delegate = self
        loginView.userPassword.delegate = self
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func SetControlDefaults(){
        self.title = "LoginVC"
        loginView = LoginView(frame: self.view.bounds)
        loginView.loginButton.addTarget(self, action: #selector(LoginClicked), for: .touchUpInside)
        
    }
    
    func render(){
        //Render loginView
        
        view.sv(loginView)
        loginView.height(100%).width(100%).centerInContainer()
        loginView.updateConstraints()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let loginViewBottomY = self.loginView.loginView.frame.origin.y + self.loginView.loginView.frame.size.height + 20
            if loginViewBottomY > keyboardSize.origin.y {
                self.loginView.loginView.frame.origin.y = self.loginView.loginView.frame.origin.y - (loginViewBottomY - keyboardSize.origin.y)
            }
            else{
                render()
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.loginView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
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
    
    func AddTapGestures(){
        loginView.registerLabel.isEnabled = true
        loginView.registerLabel.isUserInteractionEnabled = true
        let registerLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterLabelTapped(recognizer:)))
        loginView.registerLabel.addGestureRecognizer(registerLabelTapGesture)
        
        
        loginView.forgotPasswordLabel.isEnabled = true
        loginView.forgotPasswordLabel.isUserInteractionEnabled = true
        let forgotPasswordLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordTapped(recognizer:)))
        loginView.forgotPasswordLabel.addGestureRecognizer(forgotPasswordLabelTapGesture)
        
    }
    
    
}

