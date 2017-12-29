//
//  GroupAnimationViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class GroupAnimationViewController: UIViewController {

    private var toolBar: UIToolbar!
    private var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 50))
        view.addSubview(toolBar)
        
        let groupItem1 = UIBarButtonItem(title: "同时", style: .plain, target: self, action: #selector(groupAnimation1))
        
        let groupItem2 = UIBarButtonItem(title: "连续", style: .plain, target: self, action: #selector(groupAnimation2))
        
        toolBar.items = [groupItem1, groupItem2]
        
        
        animationView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        animationView.center = CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5)
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
    }
    
    //MARK:- 同时执行动画
    @objc func groupAnimation1() {
        //位移动画
        let positionAnimation = getPositionAnimation()
        
        //缩放
        let scaleAnimation = getScaleAnimation()
        
        //旋转
        let rotationAnimation = getRotationAnimation()
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, scaleAnimation, rotationAnimation]
        groupAnimation.duration = 4.0
        animationView.layer.add(groupAnimation, forKey: "groupAnimation1")
    }
    
    //MARK:- 按照顺序执行的动画
    @objc func groupAnimation2() {
        
        let currentTime = CACurrentMediaTime()

        //位移动画
        let positionAnimatin = getPositionAnimation()
        positionAnimatin.fillMode = kCAFillModeForwards
        positionAnimatin.beginTime = currentTime
        positionAnimatin.duration = 1.5
        animationView.layer.add(positionAnimatin, forKey: "position")
        
        //缩放
        let scaleAniamtion = getScaleAnimation()
        scaleAniamtion.beginTime = 1.0 + currentTime
        scaleAniamtion.fillMode = kCAFillModeForwards
        scaleAniamtion.duration = 1.0
        animationView.layer.add(scaleAniamtion, forKey: "scale")
        
        //旋转
        let rotationAnimation = getRotationAnimation()
        rotationAnimation.beginTime = 2.0 + currentTime
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.duration = 1.5
        animationView.layer.add(rotationAnimation, forKey: "rotation")
    }
    
    func getPositionAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.values = [NSValue(cgPoint: CGPoint(x: 0, y: ScreenHeight * 0.5)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.25, y: ScreenHeight * 0.5)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.25, y: ScreenHeight * 0.5 + 100)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5 + 100)),
                            NSValue(cgPoint: CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5))
                        ]
        return animation
    }
    
    func getScaleAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 0.8)
        animation.toValue = NSNumber(value: 2)
        return animation
    }
    
    func getRotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = NSNumber(value: Double.pi * 2)
        return animation
    }

}
