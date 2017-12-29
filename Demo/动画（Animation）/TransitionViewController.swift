//
//  TransitionViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {
    
    private var titles = ["fade", "moveIn", "push", "reveal", "cube", "suck", "oglFlip", "ripple", "Curl", "UnCurl", "caOpen", "caClose"]
    
    private var animationView: UIView!
    private var titleLabel: UILabel!
    
    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        
        animationView = UIView(frame: CGRect(x: 0, y: 300, width: 200, height: 300))
        animationView.center.x = ScreenWidth * 0.5
        animationView.backgroundColor = UIColor.red
        view.addSubview(animationView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 120, width: 200, height: 50))
        titleLabel.text = "\(index)"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textColor = UIColor.black
        animationView.addSubview(titleLabel)
        
        let container = UIView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 185))
        view.addSubview(container)
        
        let cols: Int = 4
        let margin: CGFloat = 15
        let btnWidth: CGFloat = (ScreenWidth - CGFloat(cols + 1) * margin) / CGFloat(cols)
        let btnHeight: CGFloat = 40
        var btnX: CGFloat = 0
        var btnY: CGFloat = 0
        
        let totals = titles.count
        for i in 0..<totals {
            
            btnX = CGFloat(i % cols) * (margin + btnWidth) + margin
            btnY = CGFloat(i / cols) * (margin + btnHeight)
            
            let button = UIButton(frame: CGRect(x: btnX, y: btnY, width: btnWidth, height: btnHeight))
            button.setTitle(titles[i], for: UIControlState.normal)
            button.backgroundColor = UIColor.orange
            button.titleLabel?.textColor = UIColor.white
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            container.addSubview(button)
            
            switch i {
            case 0:
                button.addTarget(self, action: #selector(fade), for: UIControlEvents.touchUpInside)
            case 1:
                button.addTarget(self, action: #selector(moveIn), for: UIControlEvents.touchUpInside)

            case 2:
                button.addTarget(self, action: #selector(push), for: UIControlEvents.touchUpInside)

            case 3:
                button.addTarget(self, action: #selector(reveal), for: UIControlEvents.touchUpInside)

            case 4:
                button.addTarget(self, action: #selector(cube), for: UIControlEvents.touchUpInside)

            case 5:
                button.addTarget(self, action: #selector(suck), for: UIControlEvents.touchUpInside)

            case 6:
                button.addTarget(self, action: #selector(ogFlip), for: UIControlEvents.touchUpInside)

            case 7:
                button.addTarget(self, action: #selector(ripple), for: UIControlEvents.touchUpInside)

            case 8:
                button.addTarget(self, action: #selector(curl), for: UIControlEvents.touchUpInside)

            case 9:
                button.addTarget(self, action: #selector(unCurl), for: UIControlEvents.touchUpInside)

            case 10:
                button.addTarget(self, action: #selector(caOpen), for: UIControlEvents.touchUpInside)

            case 11:
                button.addTarget(self, action: #selector(caClose), for: UIControlEvents.touchUpInside)

                default:
                break
            }
        }
    }
    
    func changeBgColor() {
        
        if index % 2 == 0 {
            animationView.backgroundColor = UIColor.blue
        }else {
            animationView.backgroundColor = UIColor.red
        }
        
        index += 1
        titleLabel.text = "\(index)"
        
    }
    
    @objc func fade() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = kCATransitionFade
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "fade")
    }
    
    @objc func moveIn() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = kCATransitionMoveIn
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "moveIn")
    }
    
    @objc func push() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = kCATransitionPush
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "push")
    }
    
    @objc func reveal() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = kCATransitionReveal
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "reveal")
    }
    
    @objc func cube() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "cube"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "cube")
    }
    
    @objc func suck() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "suckEffect"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "suckEffect")
    }
    
    @objc func ogFlip() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "oglFlip"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "oglFlip")
    }
    
    @objc func ripple() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "rippleEffect"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "rippleEffect")
    }
    
    @objc func curl() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "pageCurl"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "pageCurl")
    }
    
    @objc func unCurl() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "pageUnCurl"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "pageUnCurl")
    }
    
    @objc func caOpen() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "cameraIrisHollowOpen"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "cameraIrisHollowOpen")
    }
    
    @objc func caClose() {
        changeBgColor()
        
        let animation = CATransition()
        //动画类型
        animation.type = "cameraIrisHollowClose"
        //动画方向
        animation.subtype = kCATransitionFromRight
        animation.duration = 1.0
        animationView.layer.add(animation, forKey: "cameraIrisHollowClose")
    }
}
