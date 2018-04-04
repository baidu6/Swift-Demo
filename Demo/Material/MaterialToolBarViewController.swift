
//
//  MaterialToolBarViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/28.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialToolBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupToolBar()
    }

}

extension MaterialToolBarViewController {
    func setupToolBar() {
        let leftView1 = UIButton()
        leftView1.setTitle("leftView1", for: .normal)
        
   
        let centerView = UILabel()
        centerView.text = "CenterView"
        
        let rightView1 = UILabel()
        rightView1.text = "rightView1"

        
        let toolBar = Toolbar(leftViews: [leftView1], rightViews: [rightView1], centerViews: [centerView])
        toolBar.backgroundColor = UIColor.lightGray
        view.addSubview(toolBar)
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(100)
        }
    }
}
