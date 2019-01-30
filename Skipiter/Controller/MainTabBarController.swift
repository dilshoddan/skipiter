//
//  TabBarController.swift
//  Skipiter
//
//  Created by Admin on 1/30/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginVC = LoginViewController()
        
        let skipsVC = SkipsViewController()
        skipsVC.title = "Skips"
        let skipsItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Home"))
        skipsVC.tabBarItem = skipsItem
        
        let searchVC = SearchUserViewController()
        searchVC.title = "Search"
        
        let searchItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Search"))
        searchVC.tabBarItem = searchItem
        
        let notificationsVC = NotificationsViewController()
        let notificationsItem:UITabBarItem = UITabBarItem(title: nil,
                                                   image: UIImage(named: "Notification")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                   selectedImage: UIImage(named: "Notification"))
        notificationsVC.tabBarItem = notificationsItem
        
        let messagesVC = MessagesViewController()
        let messagesItem:UITabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(named: "Messages")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                          selectedImage: UIImage(named: "Messages"))
        messagesVC.tabBarItem = messagesItem
        
        viewControllers = [loginVC, skipsVC, searchVC, notificationsVC, messagesVC]
        
    }

}
