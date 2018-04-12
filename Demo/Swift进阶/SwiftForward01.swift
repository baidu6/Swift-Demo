//
//  SwiftForward01.swift
//  Demo
//
//  Created by 王云 on 2018/4/4.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SwiftForward01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        var mutableFibs = [01, 11, 21, 31, 41, 51]
        mutableFibs.append(6)
        mutableFibs.append(contentsOf: [7, 8, 9])
        print(mutableFibs)
        
        if mutableFibs.isEmpty {
            print("数组是空的")
        } else {
            print("数组不是空的")
        }
        
        //迭代
        for i in mutableFibs {
            print(i)
        }
        print("\n")
        //迭代除了第一个元素之外的元素
        for i in mutableFibs.dropFirst() {
            print(i)
        }
        print("\n")
        //迭代除了最后5个元素之外的元素
        for i in mutableFibs.dropLast(5) {
            print(i)
        }
        print("\n")
        //列举元素和下标
        for (index, value) in mutableFibs.enumerated() {
            print("\(index): \(value)")
        }
        print("\n")
        //map
        let mapResult = mutableFibs.map {
            return $0 * 2
        }
        print(mapResult, mutableFibs)
        print("\n")
        //filter
        let filterResult = mutableFibs.filter {
            return $0 > 2
        }
        print(filterResult, mutableFibs)
        
        for i in mutableFibs where i > 10 {
            print(i)
        }
        
        let num = mutableFibs.last {$0 > 10}
        print(num)
        
        
        //flatMap 降维 去空
        let array1 = [[1, 2, 3, 4], [11, 22, 33, 44]]
        let result1 = array1.map {
            $0.map {
                return $0 + 1
            }
        }
        print(result1)
        
        let result2 = array1.flatMap {
            $0.flatMap {
                return $0 + 1
            }
        }
        print(result2)
        
        let array2 = ["a", "b", "c", nil]
        let result3 = array2.flatMap { $0 }
        print(result3)
        
        let suits = ["a", "b", "c", "d"]
        let ranks = ["1", "2", "3", "4"]
        let result4 = suits.flatMap { suit in
            ranks.map { map in
                (suit, map)
            }
        }
        print(result4)
        print("\n")
        
        //forEach
        suits.forEach { (item) in
            if item == "a" {
                print(item)
                return
            }
            print("return后面的: \(item)")
        }
        
        for i in suits {
            if i == "a" {
                print(i)
//                return
            }
            print("return后面的: \(i)")
        }
        print("\n")
        
        
        //切片
        let fibs = [1, 2, 3, 4, 5, 6, 7, 8]
        let slice = fibs[1...]
        print(type(of: slice))
        
        let newArray = Array(slice)
        print(type(of: newArray))
    }

}

extension Sequence {
    func last(where predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}
