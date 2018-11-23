//
//  RegisterViewController.swift
//  Skipiter
//
//  Created by Admin on 11/22/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification,object: nil)
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        userName.delegate = self
        userPassword.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @objc func OkClicked(){
        navigationController?.popViewController(animated: true)
        
    }
    
    func SetControllerDefaults(){
        
        self.title = "RegisterVC"
        view.backgroundColor = ColorConstants.RegisterVC
        
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
        
        userNameLabel = UILabel()
        userNameLabel.text = "User name:"
        userName = UITextField()
        
        userPasswordLabel = UILabel()
        userPasswordLabel.text = "User password:"
        userPassword = UITextField()
        userPassword.isSecureTextEntry = true
        
        //set default UITextField attributes
        for textField in [firstName, lastName, email, userName, userPassword] {
            textField?.backgroundColor = .white
            textField?.borderStyle = .roundedRect
            textField?.isEnabled = true
            textField?.isUserInteractionEnabled = true
        }
        
        
        okButton = UIButton()
        okButton.backgroundColor = ColorConstants.LoginViewVC
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
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let selectedTextField = registerView.getSelectedTextField()
            if let selectedTextField = selectedTextField {
                let selectedTextFieldBottomY = selectedTextField.frame.origin.y + selectedTextField.frame.size.height
                if selectedTextFieldBottomY > keyboardSize.origin.y {
                    registerView.frame.origin.y = registerView.frame.origin.y - (selectedTextFieldBottomY - keyboardSize.origin.y) - 5
                }
                else{
                    render()
                }
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.registerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    //    @objc func keyboardWillShow(notification: NSNotification) {
    //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
    //            let selectedTextField = registerView.getSelectedTextField()
    //            if let selectedTextField = selectedTextField {
    //                let selectedTextFieldBottomY = selectedTextField.frame.origin.y + selectedTextField.frame.size.height
    //                if selectedTextFieldBottomY > keyboardSize.origin.y {
    //                    registerView.frame.origin.y = registerView.frame.origin.y - (selectedTextFieldBottomY - keyboardSize.origin.y) - 5
    //                }
    //            }
    //        }
    //        UIView.animate(withDuration: 0.2, animations: { () -> Void in
    //            self.registerView.layoutIfNeeded()
    //            self.view.layoutIfNeeded()
    //        })
    //    }
    //
    //    @objc func keyboardWillHide(notification: NSNotification) {
    //        render()
    //        UIView.animate(withDuration: 0.2, animations: { () -> Void in
    //            self.registerView.layoutIfNeeded()
    //            self.view.layoutIfNeeded()
    //        })
    //    }
    
    
    
}


