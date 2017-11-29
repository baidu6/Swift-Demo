//
//  TouchDetailViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class TouchDetailViewController: UIViewController {
    
    var item: String!
    
    fileprivate var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TouchDetail"
        view.backgroundColor = UIColor.white
        setupUI()
        
        if let item = item {
            titleLabel.text = item
        }
        
    }
    
    func setupUI() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let action1 = UIPreviewAction(title: item, style: .default) { [weak self](_, vc) in
            print(self?.item ?? "")
        }
        return [action1]
    }


}
