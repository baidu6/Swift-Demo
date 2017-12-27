//
//  CustomIndexView.swift
//  Demo
//
//  Created by 王云 on 2017/12/26.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class CustomIndexView: UIView {
    
    fileprivate var sectionDatas:[UILabel] = [UILabel]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor.lightGray
        
    }
    
    func setupLabels(datas: [String]) {
        let itemX: CGFloat = 0
        let itemW: CGFloat = self.bounds.size.width
        let itemH: CGFloat = 30
        var itemY: CGFloat = 0
        for i in 0..<datas.count {
            let label = UILabel(frame: CGRect(x: itemX, y: itemY, width: itemW, height: itemH))
            label.textAlignment = .center
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 15)
            label.text = datas[i]
            addSubview(label)
            
            itemY += itemH
            
            if i == datas.count - 1 {
                self.frame.size.height = itemY + itemH
            }
        }
        
    }
    
    func reloadSectionDatas(datas: [String]?) {
        guard let datas = datas else {
            return
        }
        setupLabels(datas: datas)
    }
    
}
