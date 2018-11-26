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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControllerDefaults()
        render()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        registerView.firstName.delegate = self
        registerView.lastName.delegate = self
        registerView.email.delegate = self
        registerView.userName.delegate = self
        registerView.userPassword.delegate = self
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
        registerView = RegisterView(frame: view.bounds)
        registerView.okButton.addTarget(self, action: #selector(OkClicked), for: .touchUpInside)
    }
    
    func render(){
        view.sv(registerView)
        registerView.height(100%).width(100%).centerInContainer()
        
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
                    registerView.updateConstraints()
                }
            }
        }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.registerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    
    
}


