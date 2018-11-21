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
    
    //Controls
    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = LoginColors.LoginContentColor
        //view.tintColor = LoginColors.LoginContentColor
        return view
    }()
    
    private let loginSubView: UIStackView = {
        let view = UIStackView()
        //view.backgroundColor = LoginColors.LoginContentColor
        return view
    }()
    
    private let userName: UITextField = {
        let userName = UITextField()
        userName.backgroundColor = .white
        userName.borderStyle = .roundedRect
        userName.isEnabled = true
        userName.isUserInteractionEnabled = true
        return userName
    }()
    
    private let userPassword: UITextField = {
        let userPassword = UITextField()
        userPassword.backgroundColor = .white
        userPassword.borderStyle = .roundedRect
        userPassword.isEnabled = true
        userPassword.isUserInteractionEnabled = true
        return userPassword
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = LoginColors.LoginViewControllerColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        loginButton.isEnabled = true
        loginButton.isUserInteractionEnabled = true
        
        return loginButton
    }()
    
    private let registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.textColor = LoginColors.LoginTextColor
        registerLabel.text = "Register"
        
        return registerLabel
    }()
    
    private let forgotPasswordLabel: UILabel = {
        let forgotPasswordLabel = UILabel()
        forgotPasswordLabel.textColor = LoginColors.LoginTextColor
        forgotPasswordLabel.text = "Forgot password?"
        return forgotPasswordLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil
        )
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            renderWithKeyboard(keyboardHeight + 45)
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        render()
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func render(){
        
        view.backgroundColor = LoginColors.LoginViewControllerColor
        
        //Render loginSubView view
        loginSubView.sv([registerLabel, forgotPasswordLabel])
        registerLabel.Left == loginSubView.Left
        forgotPasswordLabel.Right == loginSubView.Right
        
        //Render loginView
        view.sv(loginView)
        loginView.sv(loginSubView)
        loginView.sv([userName, userPassword, loginButton, loginSubView])
        
        loginView.height(30%).width(100%)
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
        
    }
    
    func renderWithKeyboard(_ keyboardHeight: CGFloat){
        
        view.backgroundColor = LoginColors.LoginViewControllerColor
        
        //Render loginSubView view
        loginSubView.sv([registerLabel, forgotPasswordLabel])
        registerLabel.Left == loginSubView.Left
        forgotPasswordLabel.Right == loginSubView.Right
        
        //Render loginView
        view.sv(loginView)
        loginView.sv(loginSubView)
        loginView.sv([userName, userPassword, loginButton, loginSubView])
        
        loginView.height(30%).width(100%)
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
            |-loginSubView-|,
            keyboardHeight
        )
        
    }
    
    
}

