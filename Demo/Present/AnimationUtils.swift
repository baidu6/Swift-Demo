//
//  AnimationUtils.swift
//  YHCompany
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class AnimationUtils: NSObject {
    static func animPositionY(_ view: UIView, target: CGFloat, duration: Double, timingFunction: CAMediaTimingFunction?, params: [String: AnyObject]?, delegate: AnyObject?) {
        let targetPosition = CGPoint(x: view.layer.position.x, y: target)
        animPosition(view, targetPosition: targetPosition, duration: duration, timingFunction: timingFunction, params: params, delegate: delegate)
    }
    
    static func animPosition(_ view: UIView, targetPosition: CGPoint, duration: Double, timingFunction: CAMediaTimingFunction?, params: [String: Any]?, delegate: Any?) {
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = duration
        anim.fromValue = NSValue(cgPoint: view.layer.position)
        anim.toValue = NSValue(cgPoint: targetPosition)
        if timingFunction != nil {
            anim.timingFunction = timingFunction
        }
        if params != nil {
            for (key, value) in params! {
                anim.setValue(value, forKey: key)
            }
            anim.delegate = delegate as! CAAnimationDelegate?
        }
        view.layer.add(anim, forKey: "")
        view.layer.position = targetPosition
    }

}
