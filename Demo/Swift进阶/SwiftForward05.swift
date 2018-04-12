//
//  SwiftForward05.swift
//  Demo
//
//  Created by 王云 on 2018/4/10.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import SwiftyAttributes

class SwiftForward05: UIViewController {
    
    private var label1: UILabel!
    private var label2: UILabel!
    private var label3: UILabel!
    private var label4: UILabel!
    private var label5: UILabel!
    private var label6: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
        swiftyAttributesTestFunc()
    }
    
    func setupUI() {
        label1 = UILabel()
        view.addSubview(label1)
        
        label2 = UILabel()
        view.addSubview(label2)
        
        label3 = UILabel()
        view.addSubview(label3)
        
        label4 = UILabel()
        view.addSubview(label4)
        
        label5 = UILabel()
        view.addSubview(label5)
        
        label6 = UILabel()
        view.addSubview(label6)
        
        label1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview()
        }
        
        label2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(10)
        }
        
        label3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(10)
        }
        
        label4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label3.snp.bottom).offset(10)
        }
        
        label5.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label4.snp.bottom).offset(10)
        }
        
        label6.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(label5.snp.bottom).offset(10)
        }
    }
    
    func swiftyAttributesTestFunc() {
        let attributeStr1 = "Hello World".withTextColor(.blue).withUnderlineStyle(UnderlineStyle.styleSingle)
        label1.attributedText = attributeStr1
        
        let attributeStr2 = "Hello World".withAttributes([
            .backgroundColor(.lightGray),
            .strokeColor(.black),
            .font(Font.systemFont(ofSize: 30)),
            .strokeWidth(2),
            .baselineOffset(2.2)
            ])
        label2.attributedText = attributeStr2
        
        let attributeStr3 = "Hello".withFont(Font.systemFont(ofSize: 30)) + "World".withFont(Font.systemFont(ofSize: 13))
        label3.attributedText = attributeStr3
        
        let attributeStr4 = NSAttributedString(string: "Hello World!", attributes: [.textColor(.red), .font(Font.systemFont(ofSize: 30))])
        label4.attributedText = attributeStr4
        
        let shadow = Shadow()
        shadow.shadowBlurRadius = 2
        shadow.shadowOffset = CGSize(width: 3, height: -4)
        
        let attributeStr5 = NSMutableAttributedString(string: "Hello World!")
        attributeStr5.addAttributes([.font(.systemFont(ofSize: 50)), .underlineStyle(.styleSingle), .underlineColor(.red), .kern(5), .shadow(shadow)], range: 0..<3)
        label5.attributedText = attributeStr5
    }

}
