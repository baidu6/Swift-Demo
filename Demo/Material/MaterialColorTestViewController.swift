//
//  MaterialColorTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialColorTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        let label1 = createLabel(title: "label1", textColor: Color.darkText.primary)
        label1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(100)
        }
        
        let label2 = createLabel(title: "label2", textColor: Color.darkText.secondary)
        label2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(5)
        }
        
        let label3 = createLabel(title: "label3", textColor: Color.darkText.others)
        label3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(5)
        }
        
        let label4 = createLabel(title: "label4", textColor: Color.darkText.dividers)
        label4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label3.snp.bottom).offset(5)
        }
        
        let label5 = createLabel(title: "label5", textColor: Color.lightText.primary)
        label5.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label4.snp.bottom).offset(5)
        }
        
        let label6 = createLabel(title: "label6", textColor: Color.lightText.secondary)
        label6.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label5.snp.bottom).offset(5)
        }
        
        let label7 = createLabel(title: "label7", textColor: Color.lightText.others)
        label7.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label6.snp.bottom).offset(5)
        }
    }
    
    func createLabel(title: String, fontSize: CGFloat = 15, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.backgroundColor = UIColor.lightGray
        label.textColor = textColor
        view.addSubview(label)
        return label
    }

}
