//
//  RegisterView.swift
//  Skipiter
//
//  Created by Home on 11/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia


class RegisterView: UIView {

    private var shouldSetupConstraints: Bool!
    public var registerView: UIStackView!
    
    public var userNameLabel: UILabel!
    public var userName: UITextField!
    public var emailLabel: UILabel!
    public var email: UITextField!
    public var userPasswordLabel: UILabel!
    public var userPassword: UITextField!
    public var okButton: UIButton!
    public var backButton: UIButton!
    public var activityIndicator: UIActivityIndicatorView!

    
    override init(frame:CGRect){
        super.init(frame:frame)
        shouldSetupConstraints = true
        SetControllerDefaults()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func SetControllerDefaults(){
        
        self.backgroundColor = ColorConstants.RegisterVC
        
        registerView = UIStackView()
        registerView.backgroundColor = ColorConstants.RegisterVC
        
        userNameLabel = UILabel()
        userNameLabel.text = "User name:"
        userName = UITextField()
        
        
        emailLabel = UILabel()
        emailLabel.text = "Email address:"
        email = UITextField()
        email.keyboardType = .emailAddress
        
        userPasswordLabel = UILabel()
        userPasswordLabel.text = "User password:"
        userPassword = UITextField()
        userPassword.isSecureTextEntry = true
        userPassword.textContentType = .password
        
        //set default UITextField attributes
        for textField in [userName, email, userPassword] {
            textField?.backgroundColor = .white
            textField?.borderStyle = .roundedRect
            textField?.isEnabled = true
            textField?.isUserInteractionEnabled = true
            
            textField?.autocorrectionType = .no
            textField?.autocapitalizationType = .none
            textField?.spellCheckingType = .no
        }
        
        
        okButton = UIButton()
        okButton.backgroundColor = ColorConstants.LoginViewVC
        okButton.setTitle("Save", for: .normal)
        okButton.tintColor = .white
        okButton.layer.cornerRadius = 5
        okButton.clipsToBounds = true
        okButton.isEnabled = true
        okButton.isUserInteractionEnabled = true
        
        backButton = UIButton()
        backButton.backgroundColor = ColorConstants.LoginViewVC
        backButton.setTitle("<Back", for: .normal)
        backButton.tintColor = .black
        backButton.layer.cornerRadius = 5
        backButton.clipsToBounds = true
        backButton.isEnabled = true
        backButton.isUserInteractionEnabled = true
        
    }
    
    
    override func updateConstraints(){
        if(shouldSetupConstraints){
            
            registerView.sv([userNameLabel, userName, emailLabel, email, userPasswordLabel, userPassword, okButton, backButton])
            self.sv(registerView)
            registerView.height(100%).width(100%)
            
            let heightConstant = CGFloat(30)
            let leftOffset = CGFloat(10)
            
            for label in [userNameLabel, emailLabel, userPasswordLabel] {
                label?.height(heightConstant).left(leftOffset)
            }
            
            for textField in [userName, email, userPassword] {
                textField?.height(heightConstant).left(leftOffset)
            }
            okButton.height(heightConstant + 10).left(leftOffset)
            
            registerView.layout(
                (2*heightConstant),
                |-userNameLabel-|,
                |-userName-|,
                13,
                |-emailLabel-|,
                |-email-|,
                13,
                |-userPasswordLabel-|,
                |-userPassword-|,
                23,
                |-okButton-|
            )
            
            backButton.Left == self.Left
            backButton.height(4%).width(18%).top(4%)
            
        }
        super.updateConstraints()
    }

}
