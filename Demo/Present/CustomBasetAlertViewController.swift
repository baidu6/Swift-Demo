//
//  CustomAlertViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/31.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CustomBasetAlertViewController: CustomPresentScaleController {
    
    var container: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        container = UIView()
        container.layer.cornerRadius = 5
        container.layer.masksToBounds = true
        container.backgroundColor = UIColor.white
        view.addSubview(container)
        
        container.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }

}

class CustomTipsViewController: CustomBasetAlertViewController {
    
    private var titleLabel: UILabel!
    private var tipsLabel: UILabel!
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "提示"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.numberOfLines = 1
        container.addSubview(titleLabel)
        
        tipsLabel = UILabel()
        tipsLabel.textColor = UIColor.darkGray
        tipsLabel.text = "今天是个好日子，今天真的是个好日子啊！哈哈哈哈哈！今天是个好日子，今天真的是个好日子啊！哈哈哈哈哈！今天是个好日子，今天真的是个好日子啊！哈哈哈哈哈！"
        tipsLabel.textAlignment = .center
        tipsLabel.font = UIFont.systemFont(ofSize: 14)
        tipsLabel.numberOfLines = 0
        container.addSubview(tipsLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
