//
//  MaterialFABMenuViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/27.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialFABMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupMenu()
    }

}

extension MaterialFABMenuViewController {
    func setupMenu() {
        let menu = FABMenu(frame: CGRect(x: (SCREEN_WIDTH - 80) * 0.5, y: 300, width: 80, height: 80))
        view.addSubview(menu)
        
        let button = FABButton(title: "Tap")
        menu.fabButton = button
        
        let item1 = FABMenuItem()
        item1.fabButton.pulseColor = .orange
        item1.fabButton.tintColor = .red
        item1.title = "Item1"
        
        let item2 = FABMenuItem()
        item2.title = "Item2"
        
        let item3 = FABMenuItem()
        item3.title = "Item3"
        
        menu.fabMenuItems = [item1, item2, item3]
        
    }
    
}
