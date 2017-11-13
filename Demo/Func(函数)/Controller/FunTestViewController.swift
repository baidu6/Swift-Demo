//
//  FunTestViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/13.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class FunTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        mul(of: 9)
        
        var s = 3
        mul(result: &s, 1, 2, 3, 4)
        print(s)
        
        print(square(n: 3))
        print(squareExpression(3))
        
        let numbers = [1, 3, 4, 5, 6]
        print(numbers.map(square))
        print(numbers.map(squareExpression))
        print(numbers.map{$0 + 100})
        
        let result = makeCounter()
        print(result) 
    }

    //默认参数
    func mul(_ m: Int = 9, of n: Int) {
        print(m * n)
    }
    
    //inout参数(在函数内部修改参数值)
    func mul(result: inout Int, _ numbers: Int ...) {
        result = numbers.reduce(1, *)
        print(result)
    }
    
    //计算平方(函数和闭包分别表达)
    func square(n: Int) -> Int {
        return n * n
    }
    let squareExpression = { (n: Int) -> Int in
        return n * n
    }
    
    //函数同样是一个Closure
    func makeCounter() -> () -> Int {
        var value = 0
        func increment() -> Int {
            value += 1
            return value
        }
        return increment
    }
}
