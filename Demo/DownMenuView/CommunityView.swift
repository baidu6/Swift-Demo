//
//  CommunityView.swift
//  Demo
//
//  Created by 王云 on 2018/1/25.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CommunityView: UIView {
    private var iconView: UIImageView!
    private var titleLabel: UILabel!
    private var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 6
        layer.masksToBounds = true
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        iconView = UIImageView(image: UIImage(named: "chooser-moment-icon-place"))
        addSubview(iconView)
        
        titleLabel = UILabel()
        titleLabel.text = "未找到对应小区请点此提交!"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        addSubview(titleLabel)
        
        button = UIButton()
        button.setTitle("提交", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.blue
        addSubview(button)
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(15)
        }
        
        button.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
}
