//
//  MaterialSwitchViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/27.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialSwitchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupSwitch()
    }
    
    func setupSwitch() {
        let switchView = Switch(state: .off, style: .dark, size: .small)
        switchView.delegate = self
        view.addSubview(switchView)
        
        switchView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}

extension MaterialSwitchViewController: SwitchDelegate {
    func switchDidChangeState(control: Switch, state: SwitchState) {
        print(state.rawValue)
    }
}
