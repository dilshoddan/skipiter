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
    public var loginView: LoginView!
    public var splashScreen: SplashView!
    private var coreDataWorker: CoreDataWorker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        navigationController?.isNavigationBarHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        hero.isEnabled = true
        SetControlDefaults()
        render()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        SetDBDefaults()
        AddTapGestures()
        
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func SetControlDefaults(){
        self.title = "LoginVC"
        
        loginView = LoginView(frame: self.view.bounds)
        loginView.hero.id = "loginView"
        loginView.loginButton.addTarget(self, action: #selector(LoginClicked), for: .touchUpInside)
        loginView.userName.delegate = self
        loginView.userPassword.delegate = self
        loginView.hero.modifiers = [.cascade(delta: 1, direction: CascadeDirection.bottomToTop, delayMatchedViews: true), .scale(1.5)]
        
        
        
    }
    
    func render(){
        //Render loginView
        
        view.sv(loginView)
        loginView.height(100%).width(100%).centerInContainer()
        loginView.updateConstraints()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginView.userName:
            loginView.userPassword.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
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
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func LoginClicked(){
        let userName = loginView.userName.text
        let userPassword = loginView.userPassword.text
        if let userName = userName,
            let userPassword = userPassword,
            !(userName.isEmpty),
            !(userPassword.isEmpty)
        {
            self.view.endEditing(true)
            loginView.activityIndicator.isHidden = false
            loginView.activityIndicator.startAnimating()
            
            
            AlamofireWorker.loginPromise(with: userName, and: userPassword)
                .done { loggedIn -> Void in
                    if loggedIn {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = MainNavigationController(rootViewController: MainTabBarController())
//                        self.navigationController?.pushViewController(skipsVC, animated: true)
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "User name and password do not match", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("User name and password do not match")
                        }))
                        self.present(alertController, animated: true, completion: nil)
                        self.loginView.userName.text = ""
                        self.loginView.userPassword.text = ""
                    }
                    self.loginView.activityIndicator.stopAnimating()
                    self.loginView.activityIndicator.isHidden = true
                    self.loginView.activityIndicator.removeFromSuperview()
                }
                .catch { error in
                    //Handle error or give feedback to the user
                    print(error.localizedDescription)
            }
            
            //AlamofireWorker.login(with: userName, and: userPassword, self)
        }
        
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
    
    func SetDBDefaults(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataWorker = CoreDataWorker(appDelegate: appDelegate)
    }
    
    
}

