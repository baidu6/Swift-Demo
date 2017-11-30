//
//  UIView+Extension.swift
//  Demo
//
//  Created by 王云 on 2017/11/30.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

var ContainerViewKey = "Container"
extension UIView {
    
    weak var containerView: UIView? {
        get {
            return objc_getAssociatedObject(self, &ContainerViewKey) as? UIView
        }
        set(view) {
            objc_setAssociatedObject(self, &ContainerViewKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func startPreviewLoading() {
        layer.masksToBounds = true
        let bgColor = UIColor.lightGray
        let duration: TimeInterval = 1.5
        backgroundColor = bgColor
        
        let gradienLayer = CAGradientLayer()
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
        
        func animate() {
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(cgPoint: CGPoint(x: -kShadowWidth / 2.0, y: self.frame.size.height / 2.0))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.frame.size.width + kShadowWidth / 2.0, y: self.frame.size.height / 2.0))
            animation.duration = duration
            animation.repeatCount = MAXFLOAT
            gradienLayer.add(animation, forKey: "position")
        }
        
        animate()
        
    }
    
    func stopPreviewLoading() {
        clear()
    }
    
    func setupContainerView() {
        clear()
        containerView = UIView(frame: self.bounds)
        containerView?.backgroundColor = UIColor.white
        addSubview(containerView!)
        bringSubview(toFront: containerView!)
        
    }
    
    func clear() {
        if let containerView = containerView {
            containerView.removeFromSuperview()
        }
    }
}



