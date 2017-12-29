//
//  BaseAnimationViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UIViewController {
    
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
        
        let positionItem = UIBarButtonItem(title: "位移", style: .plain, target: self, action: #selector(positionAnimation))
        
        let opacityItem = UIBarButtonItem(title: "透明度", style: .plain, target: self, action: #selector(opactiyAnimation))
        
        let scaleItem = UIBarButtonItem(title: "缩放", style: .plain, target: self, action: #selector(scaleAnimation))
        
        let rotationItem = UIBarButtonItem(title: "旋转", style: .plain, target: self, action: #selector(rotationAnimation))
        
        let bgColorItem = UIBarButtonItem(title: "背景色", style: .plain, target: self, action: #selector(bgColorAnimation))
        
        toolBar.items = [positionItem, opacityItem, scaleItem, rotationItem, bgColorItem]
        
        
        animationView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        animationView.center = CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5)
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
        
    }
    
    //MARK:- 位移
    @objc func positionAnimation() {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = NSNumber(value: 0)
        animation.duration = 2.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = NSNumber(value: Int(ScreenWidth))
        animationView.layer.add(animation, forKey: "positionAnimation")
    }
    
    //MARK:- 透明度
    @objc func opactiyAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = NSNumber(value: 1.0)
        animation.toValue = NSNumber(value: 0.2)
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "opactiyAnimation")
    }
    
    //MARK:- 缩放
    @objc func scaleAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 1.0)
        animation.toValue = NSNumber(value: 2.0)
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "scaleAnimation")
    }
    
    //MARK:- 旋转
    @objc func rotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber(value: Double.pi)
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    //MARK:- 背景色
    @objc func bgColorAnimation() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.blue.cgColor
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "colorAnimation")
        
    }

}
