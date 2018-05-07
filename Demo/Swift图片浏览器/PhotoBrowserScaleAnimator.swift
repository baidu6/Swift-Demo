//
//  PhotoBrowserScaleAnimator.swift
//  Demo
//
//  Created by 王云 on 2018/5/4.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class PhotoBrowserScaleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    //是present or dismiss
    var isPresented: Bool = false
    
    //动画时长
    var duration: TimeInterval = 0.25
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresented {
            animationTransitionIn(transitionContext)
        } else {
            animationTransitionOut(transitionContext)
        }
        
    }
    
    func animationTransitionIn(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: presentedVC)
        containerView.addSubview(toView)
    
        let targetView = toView.subviews.last!
        targetView.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
        targetView.alpha = 0

        UIView.animate(withDuration: duration, animations: {
            targetView.alpha = 1.0
            targetView.transform = CGAffineTransform.identity
        }) { (flag) in
            transitionContext.completeTransition(flag)
        }
    }
    
    func animationTransitionOut(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
   
        UIView.animate(withDuration: duration, animations: {
            fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            fromView.alpha = 0
        }) { (flag) in
            if flag {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(flag)
        }
    }
    

}
