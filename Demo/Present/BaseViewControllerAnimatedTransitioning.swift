//
//  CustomViewControllerAnimatedTransitioning.swift
//  Demo
//
//  Created by 王云 on 2018/1/29.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class BaseViewControllerAnimatedTransitioning:NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    var isPresented = true
    var duration = 0.4
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            _animateTransitionIn(transitionContext)
        }else {
            _animateTransitionOut(transitionContext)
        }
    }
    
    fileprivate func _animateTransitionIn(_ transitionContext: UIViewControllerContextTransitioning) {}
    fileprivate func _animateTransitionOut(_ transitionContext: UIViewControllerContextTransitioning) {}
}

class ViewControllerAnimatedTransitioningScale: BaseViewControllerAnimatedTransitioning {
    
    override init() {
        super.init()
        self.duration = 0.2
    }
    
    fileprivate override func _animateTransitionIn(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: presentedVC)
        containerView.addSubview(toView)
        
        let targetView = toView.subviews.last!
        targetView.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
        targetView.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            targetView.alpha = 1
            targetView.transform = CGAffineTransform.identity
        }) { (flag) in
            transitionContext.completeTransition(flag)
        }
    }
    
    fileprivate override func _animateTransitionOut(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0
        }) { (flag) in
            if flag {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(flag)
        }
    }
}

//MARK:- Move
class ViewControllerAnimatedTransitioningMove: BaseViewControllerAnimatedTransitioning {
    fileprivate override func _animateTransitionIn(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let presentedVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: presentedVC)
        containerView.addSubview(toView)
        
        if let fromView = presentedVC.presentingViewController?.view{
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            }, completion: nil)
        }
        
        let targetView = toView.subviews[0]
        let y = targetView.center.y

        targetView.layer.position = CGPoint(x: targetView.center.x, y: y + targetView.frame.size.height)
        AnimationUtils.animPositionY(targetView, target: y, duration: duration, timingFunction: CAMediaTimingFunction(controlPoints: 0, 1, 0.9, 1), params:["Context": transitionContext], delegate: self)
    }
    
    fileprivate override func _animateTransitionOut(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            else {
                return
        }
        UIView.animate(withDuration: duration, animations: {
            toVC.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        let targetView = fromView.subviews[0]
        let y = targetView.center.y
        AnimationUtils.animPositionY(targetView, target: y + targetView.frame.size.height, duration: duration, timingFunction: CAMediaTimingFunction(controlPoints: 0, 1, 0.9, 1), params:["Context": transitionContext, "View": fromView], delegate: self)
    }
    
    //MARK:CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = anim.value(forKey: "Context") as? UIViewControllerContextTransitioning {
            if let presentedView = anim.value(forKey: "View") as? UIView {
                presentedView.removeFromSuperview()
            }
            transitionContext.completeTransition(flag)
        }
    }
}

//MARK:- Spread
class ViewControllerAnimatedTransitioningSpread: BaseViewControllerAnimatedTransitioning {
    override init() {
        super.init()
        self.duration = 0.5
    }
    override func _animateTransitionIn(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
 
        let startRadius: CGFloat = 10
        let endRadius:CGFloat = sqrt(pow(ScreenWidth * 0.5, 2) + pow(ScreenHeight * 0.5, 2))
        let startPath = UIBezierPath(arcCenter: containerView.center, radius: startRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let endPath = UIBezierPath(arcCenter: containerView.center, radius: endRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let maskLayer = CAShapeLayer()
        toView.layer.mask = maskLayer
        maskLayer.path = startPath.cgPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = duration
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.delegate = self
        animation.setValue(transitionContext, forKey: "Context")
        maskLayer.add(animation, forKey: "PathAnimation")
        
        maskLayer.path = endPath.cgPath
    }
    
    override func _animateTransitionOut(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }

        let containerView = transitionContext.containerView
        let endRadius:CGFloat = sqrt(pow(ScreenWidth * 0.5, 2) + pow(ScreenHeight * 0.5, 2))
        let startPath = UIBezierPath(arcCenter: containerView.center, radius: endRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let endPath = UIBezierPath(arcCenter: containerView.center, radius: 10, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let maskLayer = CAShapeLayer()
        fromView.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = duration
        animation.delegate = self
        animation.setValue(transitionContext, forKey: "Context")
        animation.setValue(fromView, forKey: "View")
        maskLayer.add(animation, forKey: "PathAnimation")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let context = anim.value(forKey: "Context") as? UIViewControllerContextTransitioning {
            if let fromView = anim.value(forKey: "View") as? UIView {
                fromView.layer.mask = nil
                fromView.removeFromSuperview()
            }
            context.completeTransition(true)
        }
    }
}
