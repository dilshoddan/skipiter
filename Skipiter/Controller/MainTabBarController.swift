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

        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        let profileItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Me_G")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Me_S"))
        profileItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        profileVC.tabBarItem = profileItem
        
        let skipsVC = SkipsViewController()
        skipsVC.title = "Skips"
        let skipsItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Home_S"))
        skipsItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        skipsVC.tabBarItem = skipsItem
        
        let searchVC = SearchUserViewController()
        searchVC.title = "Search"
        
        let searchItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Search_S"))
        searchItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        searchVC.tabBarItem = searchItem
        
        let notificationsVC = NotificationsViewController()
        let notificationsItem:UITabBarItem = UITabBarItem(title: nil,
                                                   image: UIImage(named: "Notification")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                   selectedImage: UIImage(named: "Notification_S"))
        notificationsItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        notificationsVC.tabBarItem = notificationsItem
        
        let messagesVC = MessagesViewController()
        let messagesItem:UITabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(named: "Messages")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                          selectedImage: UIImage(named: "Messages_S"))
        messagesItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        messagesVC.tabBarItem = messagesItem
        
        //viewControllers = [loginVC, skipsVC, searchVC, notificationsVC, messagesVC]
        
        viewControllers = [skipsVC, searchVC, profileVC, notificationsVC, messagesVC]
        self.tabBar.tintColor = ColorConstants.LoginViewVC
    }

}
