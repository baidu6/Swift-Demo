//
//  PathTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/27.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class PathTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        addCurve()
    }
    
    func addCurve() {
        
        //strokeEnd
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 30, y: 200))
        let controlPoint1 = CGPoint(x: 105, y: 100)
        let controlPoint2 = CGPoint(x: 255, y: 300)
        path1.addCurve(to: CGPoint(x: 330, y: 200), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        let layer = CAShapeLayer()
        layer.path = path1.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 2.0
        layer.add(animation, forKey: "animation")
        
        
        //strokeStart
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 30, y: 400))
        path2.addCurve(to: CGPoint(x: 330, y: 400), controlPoint1: CGPoint(x: 105, y: 300), controlPoint2: CGPoint(x: 255, y: 500))
        
        let layer2 = CAShapeLayer()
        layer2.path = path2.cgPath
        layer2.strokeColor = UIColor.black.cgColor
        layer2.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(layer2)
        
        let animation2 = CABasicAnimation(keyPath: "strokeStart")
        animation2.fromValue = 1.0
        animation2.toValue = 0.0
        animation2.duration = 2.0
        layer2.add(animation2, forKey: "animation2")
        
        
        
        //stroke
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: 30, y: 600))
        path3.addCurve(to: CGPoint(x: 330, y: 600), controlPoint1: CGPoint(x: 105, y: 500), controlPoint2: CGPoint(x: 255, y: 700))
        
        let layer3 = CAShapeLayer()
        layer3.path = path3.cgPath
        layer3.strokeColor = UIColor.black.cgColor
        layer3.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(layer3)
        
        let animationLeft = CABasicAnimation(keyPath: "strokeStart")
        animationLeft.fromValue = 0.5
        animationLeft.toValue = 0
        animationLeft.duration = 2.0
        layer3.add(animationLeft, forKey: "animationLeft")
        
        let animationRight = CABasicAnimation(keyPath: "strokeEnd")
        animationRight.fromValue = 0.5
        animationRight.toValue = 1.0
        animationRight.duration = 2.0
        layer3.add(animationRight, forKey: "animationRight")
        
    }

}
