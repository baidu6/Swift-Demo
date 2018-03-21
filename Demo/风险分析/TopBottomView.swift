//
//  TopBottomView.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

//MARK:- 上下结构的View
class TopBottomView: UIView {
    
    var topLabel: UILabel!
    var bottomLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        topLabel = UILabel()
        topLabel.textAlignment = .center
        topLabel.textColor = UIColor.black
        topLabel.text = "23"
        topLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(topLabel)
        
        bottomLabel = UILabel()
        bottomLabel.textAlignment = .center
        bottomLabel.textColor = UIColor.lightGray
        bottomLabel.text = "成交量"
        bottomLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(bottomLabel)
        
        topLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
}
