//
//  RegisterViewController.swift
//  Skipiter
//
//  Created by Admin on 11/22/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Stevia
import PromiseKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    public var registerView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetControllerDefaults()
        render()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        registerView.backButton.addTarget(self, action: #selector(BackButtonTapped), for: .touchUpInside)
        
        SetDBDefaults()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case registerView.email:
            registerView.userPassword.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true;
    }
    
    @objc func OkClicked() {
        if let userName = registerView.userName.text,
            let email = registerView.email.text,
            let userPassword = registerView.userPassword.text
        {
            registerView.activityIndicator.isHidden = false
            registerView.activityIndicator.startAnimating()
            
            AlamofireWorker.registerUser(with: userName, and: email, and: userPassword)
                .done{ registered in
                    if registered {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Cannot register", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Cannot register")
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    self.registerView.activityIndicator.stopAnimating()
                    self.registerView.activityIndicator.isHidden = true
                    self.registerView.activityIndicator.removeFromSuperview()
                    
            }
            .catch { error in
                //Handle error or give feedback to the user
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    func SetControllerDefaults(){
        
        self.title = "RegisterVC"
        view.backgroundColor = ColorConstants.RegisterVC
        registerView = RegisterView(frame: view.bounds)
        registerView.okButton.addTarget(self, action: #selector(OkClicked), for: .touchUpInside)
        
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
    
    func SetDBDefaults(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        coreDataWorker = CoreDataWorker(appDelegate: appDelegate)
    }
    
    @objc func BackButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    
}


