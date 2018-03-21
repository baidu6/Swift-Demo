//
//  GradeView.swift
//  Demo
//
//  Created by 王云 on 2018/3/13.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
class GradeView: UIView {
    
    private var bgView: UIView!
    private var topView: UIView!
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var numberLabel: UILabel!
    private var timeLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        var shadowView = UIView()
        shadowView.backgroundColor = UIColor.white
        shadowView = PackageManager.makeShadow(view: shadowView, radius: 8)
        addSubview(shadowView)
        
        bgView = UIView()
        bgView = PackageManager.makeRounded(view: bgView, corner: 8)
        addSubview(bgView)
        
        topView = UIView()
        topView.backgroundColor = UIColor.ColorHex(hex: "#F9B347")
        bgView.addSubview(topView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.ColorHex(hex: "#F4A43A")
        bgView.addSubview(contentView)
        
        titleLabel = UILabel()
        titleLabel.text = "流动性评分"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: autoFont(size: 30))
        titleLabel.textAlignment = .center
        topView.addSubview(titleLabel)
        
        numberLabel = UILabel()
        contentView.addSubview(numberLabel)
        
        timeLabel = UILabel()
        timeLabel.textAlignment = .left
        timeLabel.textColor = UIColor.ColorHex(hex: "#FCEED9")
        timeLabel.font = UIFont(name: Font_Medium, size: autoFont(size: 26))
        contentView.addSubview(timeLabel)
        
        bgView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(autoWidth(width: 20))
            make.right.equalToSuperview().offset(autoWidth(width: -20))
        }
        
        shadowView.snp.makeConstraints { (make) in
            make.edges.equalTo(bgView)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(autoHeight(height: 62))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
//        numberLabel.backgroundColor = UIColor.red
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(numberLabel.snp.right)
            make.bottom.equalTo(numberLabel.snp.bottom).offset(-autoHeight(height: 24))
        }
        
        displayData(numberStr: "3.5", totalStr: "5.0", timeStr: "5个月")
    }
    
    func displayData(numberStr: String, totalStr: String, timeStr: String) {
        let string = numberStr + "/" + totalStr
        let numAttri = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: Font_Medium, size: autoFont(size: 90))!]
        let totalArrti = [NSAttributedStringKey.foregroundColor: UIColor.ColorHex(hex: "#FFF8EE"), NSAttributedStringKey.font: UIFont(name: Font_Medium, size: autoFont(size: 40))!]
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttributes(numAttri, range: NSMakeRange(0, numberStr.count))
        attributedString.addAttributes(totalArrti, range: NSMakeRange(numberStr.count, totalStr.count + 1))
        numberLabel.attributedText = attributedString
        
        timeLabel.text = "（周期：\(timeStr)）"
    }
}
