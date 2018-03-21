//
//  IQKeyBoardViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class IQKeyBoardViewController: UIViewController {
    
    var tableView: UITableView!
    var submitField: UITextField!
    var cancelField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {

        submitField = UITextField(frame: CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 40))
        submitField.placeholder = "请输入..."
        submitField.clearButtonMode = .whileEditing
        submitField.returnKeyType = .next
        submitField.borderStyle = .roundedRect
        
        cancelField = UITextField(frame: CGRect(x: 0, y: submitField.frame.maxY + 10, width: view.bounds.size.width, height: 40))
        cancelField.borderStyle = .roundedRect
        cancelField.placeholder = "请输入..."
        
        tableView = UITableView(frame: CGRect(x: 0, y: cancelField.frame.maxY, width: view.bounds.size.width, height: view.bounds.size.height - 100))
        tableView.register(IQKeyBoardCell.self, forCellReuseIdentifier: "IQKeyBoardCellID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        view.addSubview(submitField)
        view.addSubview(cancelField)
        
    }
}



extension IQKeyBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IQKeyBoardCellID") as! IQKeyBoardCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

class IQKeyBoardCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var textField: UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.text = "Hello"
        contentView.addSubview(titleLabel)
        
        textField = UITextField()
        textField.placeholder = "请输入..."
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.delegate = self
        contentView.addSubview(textField)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.left.equalTo(titleLabel.snp.right).offset(20)
        }
    }
}

extension IQKeyBoardCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if IQKeyboardManager.sharedManager().canGoNext == true {
            IQKeyboardManager.sharedManager().goNext()
        }
        return true
    }
}
