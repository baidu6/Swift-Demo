//
//  MaterialButtonTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialButtonTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        let flatBtn = FlatButton(title: "FlatBtn", titleColor: UIColor.red)
        view.addSubview(flatBtn)
        
        flatBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let raiseBtn = RaisedButton(title: "RaiseBtn", titleColor: .white)
        raiseBtn.pulseColor = .white
        raiseBtn.backgroundColor = Color.blue.base
        view.addSubview(raiseBtn)
        raiseBtn.snp.makeConstraints { (make) in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(flatBtn.snp.bottom).offset(10)
        }
        
        let fabBtn = FABButton(title: "FABBtn", titleColor: .white)
        fabBtn.backgroundColor = Color.red.base
        fabBtn.pulseColor = UIColor.black
        view.addSubview(fabBtn)
        fabBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(raiseBtn.snp.bottom).offset(10)
        }
        
        let iconBtn = IconButton(image: UIImage(named: "企业图标"))
        view.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(fabBtn.snp.bottom).offset(10)
        }
    }

}
