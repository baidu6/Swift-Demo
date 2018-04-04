//
//  MaterialCardViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/27.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialCardViewController: UIViewController {
    
    private var toolBar: Toolbar!
    private var contentView: UILabel!
    private var bar: Bar!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupToolBar()
        setupContentView()
        setupBar()
        setupCard()
    }

}

extension MaterialCardViewController {
    func setupCard() {
        let card = Card()
        card.toolbar = toolBar
        card.contentView = contentView
        card.bottomBar = bar
        card.cornerRadius = 8
        view.addSubview(card)
        
        card.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func setupToolBar() {
        toolBar = Toolbar()
        toolBar.title = "TooBarTitle"
        toolBar.detail = "ToolBarDetail"
    }
    
    func setupContentView() {
        contentView = UILabel()
        contentView.numberOfLines = 0
        contentView.text = "Material is an animation and graphics framework that is used to create beautiful applications."
    }
    
    func setupBar() {
        bar = Bar()
        
        let label1 = UILabel()
        label1.text = "label1"
        
        let label2 = UILabel()
        label2.text = "label2"
        
        let label3 = UILabel()
        label3.text = "label3"
        
        let label4 = UILabel()
        label4.text = "label4"
        
        bar.leftViews = [label1, label2]
        bar.rightViews = [label3, label4]
    }
}
