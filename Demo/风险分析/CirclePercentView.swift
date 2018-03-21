//
//  CirclePercentView.swift
//  Demo
//
//  Created by 王云 on 2018/3/13.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CirclePercentView: UIView {
    
    private let circleRadius: CGFloat = autoWidth(width: 57)
    private let lineWidth: CGFloat = autoWidth(width: 6)
    
    private var bgView: UIView!
    private var titleLabel: UILabel!
    private var shapeLayer: CAShapeLayer!
    private var gradientLayer: CAGradientLayer!
    private var animation: CABasicAnimation!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        bgView = UIView()
        bgView.layer.cornerRadius = circleRadius
        bgView.layer.masksToBounds = false
        bgView.backgroundColor = UIColor.clear
        addSubview(bgView)
        
        let fillLayer = CAShapeLayer()
        fillLayer.fillColor = UIColor.ColorHex(hex: "#FBEFDB").cgColor
        fillLayer.path = UIBezierPath(arcCenter: CGPoint(x: circleRadius, y: circleRadius), radius: circleRadius - lineWidth, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true).cgPath
        bgView.layer.addSublayer(fillLayer)
        
        shapeLayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: circleRadius, y: circleRadius), radius: circleRadius - lineWidth * 0.5, startAngle: CGFloat(-Double.pi * 0.25), endAngle: CGFloat(Double.pi * 1.75), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        bgView.layer.addSublayer(shapeLayer)

        //从左到右渐变
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: circleRadius * 2, height: circleRadius * 2)
        gradientLayer.colors = [UIColor.ColorHex(hex: "#FAB83D").cgColor, UIColor.ColorHex(hex: "#EB8C32").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.mask = shapeLayer
        bgView.layer.addSublayer(gradientLayer)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.ColorHex(hex: "#633307")
        titleLabel.font = UIFont.systemFont(ofSize: autoFont(size: 36))
        titleLabel.textAlignment = .center
        bgView.addSubview(titleLabel)
        
        bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(circleRadius * 2)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
    
        displayData(title: "--", percent: 0.8)
    }
    
    func beginAnimation(toValue: Double) {
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = NSNumber(value: 0.0)
        animation.toValue = NSNumber(value: toValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "strokeEndAnimation")
    }
    
    func displayData(title: String, percent: Double) {
        titleLabel.text = title
        beginAnimation(toValue: percent)
    }
    
}
