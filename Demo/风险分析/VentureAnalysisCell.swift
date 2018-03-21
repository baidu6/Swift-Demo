//
//  VentureAnalysisBaseCell.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class VentureAnalysisCell: UITableViewCell {
  
    private var titleLabel: UILabel!
    private var leftView: TopBottomView!
    private var centerView: TopBottomView!
    var analysisView: AnalysisAnimateView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.text = "成交率"
        contentView.addSubview(titleLabel)
        
        leftView = TopBottomView()
        contentView.addSubview(leftView)
        
        centerView = TopBottomView()
        contentView.addSubview(centerView)
        
        analysisView = AnalysisAnimateView(frame: CGRect(x: ScreenWidth - 60, y: 20, width: 40, height: 40))
        contentView.addSubview(analysisView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        leftView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(ScreenWidth / 3)
        }
        centerView.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right)
            make.width.top.bottom.equalTo(leftView)
        }
        
//        analysisView.snp.makeConstraints { (make) in
//            make.top.equalTo(leftView)
//            make.width.height.equalTo(40)
//            make.right.equalToSuperview().offset(-20)
//        }
    }
    
}
