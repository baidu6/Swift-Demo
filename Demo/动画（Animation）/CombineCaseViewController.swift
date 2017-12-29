//
//  CombineCaseViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class CombineCaseViewController: UIViewController {
    
    private var toolBar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 50))
        view.addSubview(toolBar)
        
        let pathItem = UIBarButtonItem(title: "Path", style: .plain, target: self, action: #selector(pathAnimation))
        
        let dingItem = UIBarButtonItem(title: "钉钉", style: .plain, target: self, action: #selector(dingAnimation))
        
        let likeItem = UIBarButtonItem(title: "点赞", style: .plain, target: self, action: #selector(likeAnimation))
        
        toolBar.items = [pathItem, dingItem, likeItem]
        
    }

    @objc func pathAnimation() {
        
    }
    
    @objc func dingAnimation() {
        
    }
    
    @objc func likeAnimation() {
        
    }

}
