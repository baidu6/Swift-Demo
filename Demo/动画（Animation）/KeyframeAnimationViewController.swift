//
//  KeyframeAnimationViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class KeyframeAnimationViewController: UIViewController {
    
    private var toolBar: UIToolbar!
    private var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关键帧动画"
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 50))
        view.addSubview(toolBar)
        
        let keyframeItem = UIBarButtonItem(title: "关键帧", style: .plain, target: self, action: #selector(keyframeAnimation))
        
        let pathItem = UIBarButtonItem(title: "路径", style: .plain, target: self, action: #selector(pathAnimation))
        
        let shakeItem = UIBarButtonItem(title: "抖动", style: .plain, target: self, action: #selector(shakeAnimation))
        
        toolBar.items = [keyframeItem, pathItem, shakeItem]
        
        
        animationView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        animationView.center = CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5)
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
    }
    
    //MARK:- 关键帧
    @objc func keyframeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [NSValue(cgPoint: CGPoint(x: 0, y: ScreenHeight * 0.5)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.3, y: ScreenHeight * 0.5)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.3, y: ScreenHeight * 0.5 + 100)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth, y: 0))
                        ]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 2.0
        animationView.layer.add(animation, forKey: "keyframeAnimation")
    }
    
    //MARK:- 路径
    @objc func pathAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = UIBezierPath(arcCenter: CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true).cgPath
        animation.duration = 2.0
        animationView.layer.add(animation, forKey: "pathAnimation")
    }
    
    //MARK:- 抖动
    @objc func shakeAnimation() {
        print(Double.pi)
        //transform.rotation === transform.rotation.z
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.values = [NSNumber(value: -Double.pi / 180 * 4),
                            NSNumber(value: Double.pi / 180 * 4),
                            NSNumber(value: -Double.pi / 180 * 4)
                        ]
        animation.repeatCount = HUGE
        animationView.layer.add(animation, forKey: "shakeAnimation")
    }
}
