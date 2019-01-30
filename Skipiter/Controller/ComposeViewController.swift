//
//  ComposeViewController.swift
//  Skipiter
//
//  Created by Admin on 1/30/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Stevia
import Hero

class ComposeViewController: UIViewController, UITabBarDelegate {
    
    public var composeView: ComposeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Compose"
        Hero.shared.defaultAnimation = .none
        navigationController?.hero.isEnabled = true
        SetControlDefaults()
        render()
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        
    }
    
    deinit {
        
    }
    
    func SetControlDefaults(){
        
        composeView = ComposeView(frame: self.view.bounds)
        composeView.tabBar.delegate = self
    }
    
    func render(){
        
        view.sv(composeView)
        composeView.height(100%).width(100%).centerInContainer()
        composeView.updateConstraints()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case composeView.cancelItem:
            navigationController?.popViewController(animated: true)
        case composeView.acceptItem:
            SaveCompose()
            navigationController?.popViewController(animated: true)
        default:
            print("That's it")
        }
    }
    
    func SaveCompose(){
        let text = composeView.composeText.text
        if let text = text, !(text.isEmpty) {
            self.view.endEditing(true)
            composeView.activityIndicator.isHidden = false
            composeView.activityIndicator.startAnimating()
            
            AlamofireWorker.ComposeSkip(text: text)
                .done { sent -> Void in
                    if sent {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = MainNavigationController(rootViewController: MainTabBarController())
                        //                        self.navigationController?.pushViewController(skipsVC, animated: true)
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: "Sorry, Connection issues", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Sorry, Connection issues")
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    self.composeView.activityIndicator.stopAnimating()
                    self.composeView.activityIndicator.isHidden = true
                    self.composeView.activityIndicator.removeFromSuperview()
                }
                .catch { error in
                    //Handle error or give feedback to the user
                    print(error.localizedDescription)
            }
        }
    }
}
