//
//  PresentTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/31.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class PresentTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.present(CustomSpreadViewController(), animated: true, completion: nil)
    }

}
