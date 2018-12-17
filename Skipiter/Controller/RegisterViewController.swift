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
    
    private var registerView: RegisterView!
    private var coreDataWorker: CoreDataWorker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControllerDefaults()
        render()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        SetCoreDataDefaults()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case registerView.firstName:
            registerView.lastName.becomeFirstResponder()
        case registerView.lastName:
            registerView.email.becomeFirstResponder()
        case registerView.email:
            registerView.userName.becomeFirstResponder()
        case registerView.userName:
            registerView.userPassword.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true;
    }
    
    @objc func OkClicked(){
        if let firstName = registerView.firstName.text,
            let lastName = registerView.lastName.text,
            let email = registerView.email.text,
            let userName = registerView.userName.text,
            let userPassword = registerView.userPassword.text
        {
            let user = User(firstname: firstName,
                            lastName: lastName,
                            email: email,
                            userName: userName,
                            userPassword: userPassword)
            
            coreDataWorker.SaveUser(user: user)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func SetControllerDefaults(){
        
        self.title = "RegisterVC"
        view.backgroundColor = ColorConstants.RegisterVC
        registerView = RegisterView(frame: view.bounds)
        registerView.okButton.addTarget(self, action: #selector(OkClicked), for: .touchUpInside)
        
        registerView.firstName.delegate = self
        registerView.lastName.delegate = self
        registerView.email.delegate = self
        registerView.userName.delegate = self
        registerView.userPassword.delegate = self
    }
    
    func render(){
        view.sv(registerView)
        registerView.height(100%).width(100%).centerInContainer()
        
        registerView.updateConstraints()
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
    
    func SetCoreDataDefaults(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataWorker = CoreDataWorker(appDelegate: appDelegate)
    }
    
    
}


