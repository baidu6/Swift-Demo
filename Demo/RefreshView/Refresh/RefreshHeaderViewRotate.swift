//
//  RefreshHeaderViewRotate.swift
//  Demo
//
//  Created by 王云 on 2018/3/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class RefreshHeaderViewRotate: RefreshHeaderViewBase {
    
    internal var shapeViewFrame: CGRect!
    internal var shapeView: UIView!
    internal let Bottom: CGFloat = 1
    internal let Radius: CGFloat = 12
    internal var _height: CGFloat = 0
    
    override func config() {
        super.config()
        
        let x = self.frame.size.width * 0.5
        _height = self.frame.size.height
        shapeViewFrame = CGRect(x: x - Radius, y: _height - Radius * 2 - Bottom, width: Radius * 2, height: Radius * 2)
    }

    
    private func recover() {
        shapeView.layer.removeAnimation(forKey: "rotationZ")
        shapeView.transform = CGAffineTransform.identity
        shapeViewFrame.origin.y = _height - Radius * 2 - Bottom
        shapeView.frame = shapeViewFrame
    }
    
    override func onNoneFromNormal() {
        super.onNoneFromNormal()
        recover()
    }
    
    override func onNoneFromRefreshing() {
         super.onNoneFromRefreshing()
        recover()
    }
    
    override func onRefreshing() {
        super.onRefreshing()
        UIView.animate(withDuration: 0.25) {
            self.shapeView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            var center = self.shapeView.center
            center.y = self._height * 0.5
            self.shapeView.center = center
        }
        
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.byValue = -(Double.pi * 2)
        anim.duration = 1
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(controlPoints: 0.8, 0, 0.2, 1)
        self.shapeView.layer.add(anim, forKey: "rotationZ")
    }
    
    override func onStateChangeWithOffset(_ offset: CGPoint) {
        super.onStateChangeWithOffset(offset)
        
        if !scrollView.isDragging {
            return
        }
        var radian: CGFloat = 0
        if offset.y <= originalHeight {
            radian = CGFloat(Double.pi * 2) * offset.y / originalHeight * 2
            shapeView.transform = CGAffineTransform(rotationAngle: radian)
        }else {
            let dY = offset.y - originalHeight
            let scale = min(5, dY / 100) + 1
            var center = shapeView.center
            center.y = _height - scale * Radius - Bottom
            shapeView.center = center
            shapeView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}

class RefreshHeaderViewRotateWithIcon: RefreshHeaderViewRotate {
    override func config() {
        super.config()
        shapeView = UIImageView(image: UIImage(named: "企业图标"))
        shapeView.frame = shapeViewFrame
        addSubview(shapeView)
    }
}
