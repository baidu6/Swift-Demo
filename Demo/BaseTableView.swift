//
//  BaseTableView.swift
//  Demo
//
//  Created by 王云 on 2017/11/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
