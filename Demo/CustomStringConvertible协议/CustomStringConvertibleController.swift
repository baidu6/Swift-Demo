//
//  CustomStringConvertibleController.swift
//  Demo
//
//  Created by 王云 on 2018/2/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

//CustomStringConvertible在结构体中的使用
struct Circle {
    var point: CGPoint
    var radius: CGFloat
   
}
extension Circle: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return "point: \(point) radius: \(radius)"
    }
    var debugDescription: String {
        return "radius: \(radius) point: \(point)"
    }
}

//CustomStringConvertible在类中的使用
class Triangle {
    var length: CGFloat = 1
    var diamter: CGFloat = 0
    init() {
        
    }
}
extension Triangle: CustomStringConvertible {
    var description: String {
        return "Triangle的长度: \(length) 直径： \(diamter)"
    }
}

//CustomStringConvertible在控制器中的使用
class CustomStringConvertibleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let circle = Circle(point: CGPoint.zero, radius: 10)
        print(circle)
        debugPrint(circle)
        
        let triangle = Triangle()
        print(triangle)
    }
}
extension CustomStringConvertibleController {
    override var description: String {
        return "CustomStringConvertibleController的打印信息 "
    }
}



