//
//  AlertTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class AlertTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        let alertFieldBtn = UIButton(type: .custom)
        alertFieldBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        alertFieldBtn.setTitle("AlertField", for: .normal)
        alertFieldBtn.setTitleColor(UIColor.white, for: .normal)
        alertFieldBtn.backgroundColor = UIColor.orange
        alertFieldBtn.addTarget(self, action: #selector(alertFieldTest), for: .touchUpInside)
        view.addSubview(alertFieldBtn)
    }

    @objc func alertFieldTest() {
        let alertVC = UIAlertController(title: "My Alert", message: "Please Enter Your Name", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            let name = alertVC.textFields![0].text
            let pwd = alertVC.textFields![1].text
            print(name, pwd)
        }
        alertVC.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        
        alertVC.addTextField { (nameField) in
            nameField.placeholder = "at least 6 characters"
        }
        
        alertVC.addTextField { (passwordField) in
            passwordField.placeholder = "password"
            passwordField.isSecureTextEntry = true
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }

}
