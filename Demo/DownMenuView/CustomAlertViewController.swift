//
//  DownMenuViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/25.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    var menuView: AlertTitleViewWithTwoButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupNav()
    }
   
    func setupNav() {
        let showMenu = UIBarButtonItem(title: "showAlert", style: .plain, target: self, action: #selector(showMenuAction))
        self.navigationItem.rightBarButtonItem = showMenu
    }
    
    @objc func showMenuAction() {

//        menuView = CustomAlertTitleView(title: "今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子！今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子！今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子！", buttonTitle: "确定")
//        menuView = CustomAlertDetailView(title: "提示", detail: "今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子！今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子！今天是个好日子，今天是个好日子，今天是个好日子，今天是个好日子！", buttonTitle: "确定")
//        menuView = CustomAlertIconView(icon: "chooser-moment-icon-place", buttonTitle: "确定")
//        menuView = AlertIconViewWithOneButton(icon: "chooser-moment-icon-place", buttonTitle: "确定")
//        menuView.confirmButtonDidClick = {
//            print("确定")
//        }
        
        menuView = AlertDetailViewWithTwoButton(title: "提示", detail: "今天是个好日子")
        menuView.cancelBtnDidClick = {
            print("Cancel")
        }
        menuView.confirmBtnDidClick = {
            print("confirm")
        }
        menuView.showMenuView()
    }

}
