//
//  PreviewLoadingViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/30.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class PreviewLoadingViewController: UIViewController {
    
    fileprivate var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
        titleLabel.startPreviewLoading()
    }
    
    func setupUI() {
        titleLabel = UILabel(frame: CGRect(x: 30, y: 100, width: view.frame.size.width - 60, height: 30))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "你今天很漂亮，很美丽，很可爱！！！！"
        titleLabel.textColor = UIColor.red
        view.addSubview(titleLabel)
       
    }

}



