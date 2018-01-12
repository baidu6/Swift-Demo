//
//  BubbleMenuView.swift
//  Demo
//
//  Created by 王云 on 2018/1/2.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

enum BubbleDirection {
    case top
    case left
    case right
    case bottom
}

class BubbleMenuView: UIView {
    
    var titles: [String] = []
    var direction = BubbleDirection.top
    
    private var buttonsArray: [UIButton] = [UIButton]()
    private var isExpand: Bool = false
    private var spacing: CGFloat = 15
    private var animationDuration: TimeInterval = 0.25
    private var itemWidth: CGFloat = 30
    private var orginalFrame: CGRect!
    
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, direction: BubbleDirection = .left, titles: [String] = ["A", "B", "C"]) {
        self.init(frame: frame)
        
        self.titles = titles
        self.direction = direction
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tap() {
        if isExpand {
           hideMenuButtons()
        }else {
            showMenuButtons()
        }
    }
    
    func setupUI() {
        self.orginalFrame = frame

        config()
        addButtons()
    }
    
    func config() {
        itemWidth = self.frame.size.width

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.addGestureRecognizer(tapGesture)
        
        self.layer.cornerRadius = self.frame.size.width * 0.5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth))
        label.text = "Tap"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.width.height.equalTo(itemWidth)
            if direction == .right {
                make.left.equalToSuperview()
            }else {
                make.right.equalToSuperview()
            }
            
            if direction == .bottom {
                make.top.equalToSuperview()
            }else {
                make.bottom.equalToSuperview()
            }
        }
   
    }
    
    func addButtons() {
        for i in 0..<titles.count {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth))
            btn.layer.cornerRadius = self.frame.size.height * 0.5
            btn.layer.masksToBounds = true
            btn.setTitle(titles[i], for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.titleLabel?.textColor = UIColor.white
            btn.titleLabel?.textAlignment = .center
            btn.backgroundColor = UIColor.orange
            btn.isHidden = true
            self.addSubview(btn)
            buttonsArray.append(btn)
        }
    }
    
    func showMenuButtons() {
        isExpand = true
        adjustExpandHeight()
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        
        for i in 0..<buttonsArray.count {
            let button = buttonsArray[i]
            button.isHidden = false
            
            //positionAnimation
            let positionAnimation = CABasicAnimation(keyPath: "position")
            var originPosition = CGPoint.zero
            var finalPosition = CGPoint.zero
            
            switch self.direction {
            case .top:
                originPosition = CGPoint(x: self.frame.width * 0.5, y: self.frame.size.height - itemWidth * 0.5)
                finalPosition = CGPoint(x: self.frame.width * 0.5, y: self.frame.size.height - (itemWidth + spacing) * CGFloat(i + 1) - spacing)
            case .left:
                originPosition = CGPoint(x: self.frame.width - itemWidth * 0.5, y: itemWidth * 0.5)
                finalPosition = CGPoint(x: self.frame.size.width - (itemWidth + spacing) * CGFloat(i + 1) - spacing, y: itemWidth * 0.5)
            case .bottom:
                originPosition = CGPoint(x: self.frame.width * 0.5, y: itemWidth * 0.5)
                finalPosition = CGPoint(x: itemWidth * 0.5, y: self.frame.size.height - (itemWidth + spacing) * CGFloat(i) - spacing)
            case .right:
                originPosition = CGPoint(x: itemWidth * 0.5, y: itemWidth * 0.5)
                finalPosition = CGPoint(x: self.frame.size.width - (itemWidth + spacing) * CGFloat(i) - spacing, y: itemWidth * 0.5)
            
            }
            
            //position
            positionAnimation.duration = animationDuration
            positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            positionAnimation.fromValue = NSValue(cgPoint: originPosition)
            positionAnimation.toValue = NSValue(cgPoint: finalPosition)
            positionAnimation.beginTime = CACurrentMediaTime() + Double(animationDuration) / Double(buttonsArray.count) * Double(i)
            positionAnimation.fillMode = kCAFillModeForwards
            positionAnimation.isRemovedOnCompletion = false
            button.layer.add(positionAnimation, forKey: "positionAnimation")
            button.layer.position = finalPosition
            
            
            //scale
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = animationDuration
            scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            scaleAnimation.beginTime = CACurrentMediaTime() + Double(animationDuration) / Double(buttonsArray.count) * Double(i) + 0.1
            scaleAnimation.fromValue = NSNumber(value: 0.01)
            scaleAnimation.toValue = NSNumber(value: 1.0)
            scaleAnimation.fillMode = kCAFillModeForwards
            scaleAnimation.isRemovedOnCompletion = false
            button.layer.add(scaleAnimation, forKey: "scaleAnimation")

            button.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
        CATransaction.commit()
    }
    
    //MARK:- 隐藏按钮
    func hideMenuButtons() {
        isExpand = false
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            self.frame = self.orginalFrame
            
            for button in self.buttonsArray {
                button.isHidden = true
                button.transform = CGAffineTransform.identity
            }
        }
        
        for i in 0..<buttonsArray.count {
            let button = buttonsArray[i]
            button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            //positionAnimation
            let positionAnimation = CABasicAnimation(keyPath: "position")
            let originPosition = button.layer.position
            var finalPosition = CGPoint.zero
            
            switch self.direction {
            case .top:
                finalPosition = CGPoint(x: self.frame.width * 0.5, y: self.frame.size.height - itemWidth)
            case .left:
                finalPosition = CGPoint(x: self.frame.width - itemWidth, y: itemWidth * 0.5)
            case .bottom:
                finalPosition = CGPoint(x: itemWidth * 0.5, y: itemWidth)
            case .right:
                finalPosition = CGPoint(x: itemWidth, y: itemWidth * 0.5)
            }
            
            //position
            positionAnimation.duration = animationDuration
            positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            positionAnimation.fromValue = NSValue(cgPoint: originPosition)
            positionAnimation.toValue = NSValue(cgPoint: finalPosition)
            positionAnimation.beginTime = CACurrentMediaTime() + Double(animationDuration) / Double(buttonsArray.count) * Double(i)
            positionAnimation.fillMode = kCAFillModeForwards
            positionAnimation.isRemovedOnCompletion = false
            button.layer.add(positionAnimation, forKey: "positionAnimation")
            
            //scale
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = animationDuration
            scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            scaleAnimation.beginTime = CACurrentMediaTime() + Double(animationDuration) / Double(buttonsArray.count) * Double(i) + 0.1
            scaleAnimation.fromValue = NSNumber(value: 1.0)
            scaleAnimation.toValue = NSNumber(value: 0.01)
            scaleAnimation.fillMode = kCAFillModeForwards
            scaleAnimation.isRemovedOnCompletion = false
            button.layer.add(scaleAnimation, forKey: "scaleAnimation")
       
        }
        
        CATransaction.commit()
        
    }
    
    //MARK:- 调整展开位置
    func adjustExpandHeight() {
        let buttonHeight = (self.frame.height + spacing) * CGFloat(buttonsArray.count)
        var frame = self.frame
        
        switch direction {
        case .top:
            frame.origin.y -= buttonHeight
            frame.size.height += buttonHeight
            self.frame = frame
            
        case .left:
            frame.origin.x -= buttonHeight
            frame.size.width += buttonHeight
            self.frame = frame
            
        case .bottom:
            frame.size.height += buttonHeight
            self.frame = frame
            
        case .right:
            frame.size.width += buttonHeight
            self.frame = frame
        }
    }
}
