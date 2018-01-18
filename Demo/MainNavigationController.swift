//
//  MainNavigationController.swift
//  Demo
//
//  Created by 王云 on 2018/1/15.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        return super.pushViewController(viewController, animated: animated)
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}
