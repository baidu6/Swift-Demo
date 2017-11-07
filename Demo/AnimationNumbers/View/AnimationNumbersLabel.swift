//
//  AnimationNumbersLabel.swift
//  Demo
//
//  Created by 王云 on 2017/10/31.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class AnimationNumbersLabel: UILabel {
    
    //定时器
    fileprivate var displayLink: CADisplayLink!
    
    //开始数字
    fileprivate var startNum: NSNumber!
    
    //结束数字
    fileprivate var endNum: NSNumber!
    
    fileprivate var duration: TimeInterval!
    
    fileprivate var startTime: TimeInterval!
    
    //显示文字格式
    fileprivate var format: NSString = "%d"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(_ startNum: NSNumber = NSNumber(value: 0), _ endNum: NSNumber = NSNumber(value: 100), _ duration: TimeInterval = 2.0) {
        self.text = startNum.stringValue
        self.startNum = startNum
        self.endNum = endNum
        self.duration = duration
        
        startDisplayLink()
    }
    
    func startDisplayLink() {
        if displayLink != nil {
            invalidateDisplayLink()
        }

        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkHandler))
        self.startTime = CACurrentMediaTime()
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    @objc func displayLinkHandler() {
        
        if displayLink.timestamp - self.startTime >= duration {
            
            self.text = NSString(format: self.format, self.endNum.doubleValue) as String
            
            invalidateDisplayLink()
        }else {
            
            //计算现在时刻的数字
            let currentNum = (endNum.doubleValue - startNum.doubleValue) * (displayLink.timestamp - startTime) / duration + startNum.doubleValue
            print(currentNum)
            self.text = NSString(format: self.format, currentNum) as String
            
        }
    
    }
    
    fileprivate func invalidateDisplayLink() {
        displayLink.invalidate()
    }
}
