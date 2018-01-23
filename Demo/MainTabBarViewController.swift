//
//  MainTabBarViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //home
        let home = ViewController()
        home.title = "Home"
        self.addChildViewController(MainNavigationController(rootViewController: home))
        
        //profile
        let profile = UITableViewController()
        profile.title = "Profile"
        self.addChildViewController(MainNavigationController(rootViewController: profile))
        
        setupTabBarItem()
    }
    
    
    
    func setupTabBarItem() {
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], for: UIControlState.normal)
        item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], for: UIControlState.selected)

    }
}

import RAMAnimatedTabBarController

class RAMBounceAnimation : RAMItemAnimation {
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor
    }
    
    func playBounceAnimation(_ icon : UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}
