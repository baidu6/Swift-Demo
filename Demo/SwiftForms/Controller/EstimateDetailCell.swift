//
//  EstimateDetailCell.swift
//  Demo
//
//  Created by 王云 on 2017/12/8.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwiftForms

class EstimateDetailCell: FormBaseCell {
    
    fileprivate let titleLabel = UILabel()
    
    override func configure() {
        super.configure()
        
        selectionStyle = .none
        backgroundColor = UIColor.lightGray
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor?.title
        
    }

}
