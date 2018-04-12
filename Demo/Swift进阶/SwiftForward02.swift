//
//  SwiftForward02.swift
//  Demo
//
//  Created by 王云 on 2018/4/4.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SwiftForward02: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.lightGray
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        btn.setTitle("Btn", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.setTitleColor(UIColor.white, for: .normal)
        tableView.tableFooterView = btn
        
    }

}
