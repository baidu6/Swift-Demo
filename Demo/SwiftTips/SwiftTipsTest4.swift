//
//  SwiftTipsTest4.swift
//  Demo
//
//  Created by 王云 on 2018/3/28.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SwiftTipsTest4: UIViewController {
    
    lazy var str: String = {
        return "Hello"
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let data = 1...3
        let result1 = data.map { (i: Int) -> Int in
            return i * 2
        }
        let result2 = data.lazy.map { (i: Int) -> Int in
            return i * 2
        }
        print("开始遍历")
//        for i in result1 {
//            print(i)
//            print("变化后的\(i)")
//        }
     
        for i in result2 {
            print(i)
            print("变化后的\(i)")
        }
        
        
        //where
        let nums = [11, 22, 33, 44, 55, 66, 77, 88, 99]
        for num in nums where num > 50 {
            print(num)
        }
        
    }
    
    //FIXME:- FIXME
    func todoFunc() {
       print("todoFunc")
    }
    
    //MARK:- mark
    func markFunc() {
        
    }

}

protocol MyColorProtocol {
    func colorMethod1()
    func colorMethod2()
    func colorMethod3()
}
extension MyColorProtocol {
    func colorMethod4() {
        
    }
    func colorMethod1() {
        
    }
}

class MyColor: UIColor, MyColorProtocol {
    func colorMethod1() {
        
    }
    
    func colorMethod2() {
        
    }
    
    func colorMethod3() {
        
    }
    
    class TextColor {
        static let dark = MyColor.darkGray
    }
}

