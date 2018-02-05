//
//  UIView+Extension.swift
//  Demo
//
//  Created by 王云 on 2018/1/25.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
extension UIView {
    
    //MARK: -设置锚点
    var anchorPoint: CGPoint {
        get {
            return self.layer.anchorPoint
        }
        set(value) {
            let size = self.frame.size
            let origin = self.frame.origin
            self.layer.anchorPoint = value
            self.center = CGPoint(x: size.width * value.x + origin.x, y: size.height * value.y + origin.y)
        }
    }
    
    var x: CGFloat {
        set(value) {
            var frame = self.frame
            frame.origin.x = value
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set(value) {
            var frame = self.frame
            frame.origin.y = value
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var width: CGFloat {
        set(value) {
            var frame = self.frame
            frame.size.width = value
            self.frame = frame
        }
        get {
           return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set(value) {
            var frame = self.frame
            frame.size.height = value
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
}
