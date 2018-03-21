//
//  AnalysisAnimateView.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class AnalysisAnimateView: UIView {
    
    private let lineWidth: CGFloat = 4
    private let duration: Double = 1.0
  
    private var shapeLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    private var animation: CABasicAnimation!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: bounds.size.width * 0.5 - lineWidth, startAngle: CGFloat(-Double.pi * 0.5), endAngle: CGFloat(Double.pi * 1.5), clockwise: true)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.strokeColor = UIColor.orange.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { [weak self] in
            self?.beginAnimation()
//            self?.setProgrss(30, withDuration: 0.55)
        }
    }
    
    func beginAnimation() {
        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = NSNumber(value: 0.0)
        animation.toValue = NSNumber(value: 0.5)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "strokeEndAnimation")
    }
    
    func setProgrss(_ progress: Int, animated anim: Bool = true, withDuration duration: Double) {
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = CGFloat(progress)/100.0
        CATransaction.commit()
    }
    
}
