

//
//  StaticAndClassViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/23.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class StaticAndClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }
}

//MARK:- Static的适用场景【enum的情况跟这个类似】
struct MyPoint {
    let x: Double
    let y: Double
    static let zero = MyPoint(x: 0, y: 0)
    static var oners: [MyPoint] {
        return [MyPoint(x: 1, y: 1),
                MyPoint(x: 1, y: -1),
                MyPoint(x: -1, y: 1),
                MyPoint(x: -1, y: -1)
        ]
    }
    static func add(p1: MyPoint, p2: MyPoint) -> MyPoint {
        return MyPoint(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

//MARK:- Class关键字【修饰类方法以及类的计算属性， class中现在是不能出现class的存储属性的】
protocol MyTestProtocol {
    static func foo() -> String
}
struct myTestStruct: MyTestProtocol {
    static func foo() -> String {
        return "myTestStruct"
    }
}
enum myTestEnum: MyTestProtocol {
    static func foo() -> String {
        return "myTestEnum"
    }
}
class myTestClass: MyTestProtocol {
    //在class中可以使用class
    class func foo() -> String {
        return "myTestClass"
    }
}






