//
//  BottomAlertViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/19.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class BottomAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CustomAlertTool.alertShow(alertType: .detailCancel)
    }
}
