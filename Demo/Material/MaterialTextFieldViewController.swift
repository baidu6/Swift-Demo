//
//  MaterialTextFieldViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialTextFieldViewController: UIViewController {
    
    private var passwordField: TextField!
    private var emailField: ErrorTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupPasswordField()
        setupErrorField()
    }
    
    func setupPasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 character"
        passwordField.detailColor = UIColor.orange
        passwordField.clearButtonMode = .whileEditing
//        passwordField.isVisibilityIconButtonEnabled = true
//        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        passwordField.leftView = UIImageView(image: UIImage(named: "chooser-moment-icon-place"))
        
        passwordField.dividerNormalColor = UIColor.lightGray
        passwordField.dividerActiveColor = UIColor.red
        view.addSubview(passwordField)
        
        passwordField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }

}

extension MaterialTextFieldViewController {
    func setupErrorField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect eamil"
        emailField.isClearIconButtonEnabled = true
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.placeholderAnimation = .hidden
        view.addSubview(emailField)
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}
