//
//  PreviewLoadingView.swift
//  Demo
//
//  Created by 王云 on 2017/11/30.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

let kShadowWidth: CGFloat = 60

class PreviewLoadingView: UIView {
    fileprivate var gradienLayer: CAGradientLayer!
    var bgColor: UIColor = UIColor.lightGray
    var duration: TimeInterval = 1.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = bgColor
        layer.masksToBounds = true
        
        gradienLayer = CAGradientLayer()
        gradienLayer.frame = CGRect(x: 0, y: 0, width: kShadowWidth, height: self.frame.size.height)
        gradienLayer.colors = [ bgColor.withAlphaComponent(0.1).cgColor,
                                UIColor.white.withAlphaComponent(0.25).cgColor,
                                UIColor.white.withAlphaComponent(0.4).cgColor,
                                UIColor.white.withAlphaComponent(0.25).cgColor,
                                bgColor.withAlphaComponent(0.1).cgColor
                            ]
        gradienLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradienLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradienLayer)
        
        animate()
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = NSValue(cgPoint: CGPoint(x: -kShadowWidth / 2.0, y: self.frame.size.height / 2.0))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.frame.size.width + kShadowWidth / 2.0, y: self.frame.size.height / 2.0))
        animation.duration = duration
        animation.repeatCount = MAXFLOAT
        gradienLayer.add(animation, forKey: "position")
    }
}
