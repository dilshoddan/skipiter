//
//  LoginView.swift
//  Skipiter
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia

class LoginView: UIView {
    
    public var shouldSetupConstraints = true
    public var loginView: UIView!
    public var loginSubView: UIStackView!
    public var userName: UITextField!
    public var userPassword: UITextField!
    public var loginButton: UIButton!
    public var registerLabel: UILabel!
    public var forgotPasswordLabel: UILabel!
    public var activityIndicator: UIActivityIndicatorView!
    
    let screenSize = UIScreen.main.bounds
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        shouldSetupConstraints = true
        SetControlDefaults()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
    
    override func updateConstraints(){
        if(shouldSetupConstraints){
            
            let height = CGFloat(25.0)
            let buttonHeight = CGFloat(height + 5)
            
            //Render loginSubView view
            loginSubView.sv([registerLabel, forgotPasswordLabel])
            registerLabel.Left == loginSubView.Left
            forgotPasswordLabel.Right == loginSubView.Right
            
            //Render loginView
            self.sv(loginView)
            loginView.sv(loginSubView)
            loginView.sv([userName, userPassword, loginButton, loginSubView, activityIndicator])
            
            
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
            activityIndicator.fillContainer()
            
            
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
            
        }
        super.updateConstraints()
    }
    
    func SetControlDefaults(){
        self.backgroundColor = ColorConstants.LoginViewVC
        
        loginView = UIView()
        loginView.backgroundColor = ColorConstants.LoginContent
        
        loginSubView = UIStackView()
        
        userName = UITextField()
        userName.backgroundColor = .white
        userName.borderStyle = .roundedRect
        userName.isEnabled = true
        userName.isUserInteractionEnabled = true
        userName.autocorrectionType = .no
        userName.autocapitalizationType = .none
        userName.spellCheckingType = .no
        
        userPassword = UITextField()
        userPassword.backgroundColor = .white
        userPassword.isSecureTextEntry = true
        userPassword.textContentType = .password
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
        
        registerLabel = UILabel()
        registerLabel.textColor = ColorConstants.LoginText
        registerLabel.text = "Register"
        
        forgotPasswordLabel = UILabel()
        forgotPasswordLabel.textColor = ColorConstants.LoginText
        forgotPasswordLabel.text = "Forgot password?"
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        
    }
}
