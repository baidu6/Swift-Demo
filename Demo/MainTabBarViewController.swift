//
//  MainTabBarViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //home
        let home = ViewController()
        home.title = "Home"
        self.addChildViewController(UINavigationController(rootViewController: home))
        
        //profile
        let profile = UITableViewController()
        profile.title = "Profile"
        self.addChildViewController(UINavigationController(rootViewController: profile))
        
        setupTabBarItem()
    }
    
    func setupTabBarItem() {
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], for: UIControlState.normal)
        item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], for: UIControlState.selected)

    }
}
