//
//  TabBarController.swift
//  Skipiter
//
//  Created by Admin on 1/30/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let skipsVC = SkipsViewController()
        let skipsItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Home"))
        skipsVC.tabBarItem = skipsItem
        
        let searchVC = SearchUserViewController()
        let searchItem:UITabBarItem = UITabBarItem(title: nil,
                                                  image: UIImage(named: "Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                  selectedImage: UIImage(named: "Search"))
        searchVC.tabBarItem = searchItem
        
    }

}
