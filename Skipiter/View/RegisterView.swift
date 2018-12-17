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
    public var firstNameLabel: UILabel!
    public var firstName: UITextField!
    public var lastNameLabel: UILabel!
    public var lastName: UITextField!
    public var emailLabel: UILabel!
    public var email: UITextField!
    public var userNameLabel: UILabel!
    public var userName: UITextField!
    public var userPasswordLabel: UILabel!
    public var userPassword: UITextField!
    public var okButton: UIButton!

    
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
        
        firstNameLabel = UILabel()
        firstNameLabel.text = "First name:"
        firstName = UITextField()
        
        lastNameLabel = UILabel()
        lastNameLabel.text = "Last name:"
        lastName = UITextField()
        
        emailLabel = UILabel()
        emailLabel.text = "Email address:"
        email = UITextField()
        email.keyboardType = .emailAddress
        
        userNameLabel = UILabel()
        userNameLabel.text = "User name:"
        userName = UITextField()
        
        userPasswordLabel = UILabel()
        userPasswordLabel.text = "User password:"
        userPassword = UITextField()
        userPassword.isSecureTextEntry = true
        userPassword.textContentType = .password
        
        //set default UITextField attributes
        for textField in [firstName, lastName, email, userName, userPassword] {
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
        
    }
    
    
    override func updateConstraints(){
        if(shouldSetupConstraints){
            
            registerView.sv([firstNameLabel, firstName, lastNameLabel, lastName, emailLabel, email, userNameLabel, userName, userPasswordLabel, userPassword, okButton])
            self.sv(registerView)
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
        super.updateConstraints()
    }

}
