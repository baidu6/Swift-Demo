//
//  LineSerachViewController.swift
//  Demo
//
//  Created by 王云 on 2018/7/2.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

protocol SearchType {
    func search(items: Array<Int>, item: Int) -> Int
}

class LineSerachViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "线性查找方法"
        view.backgroundColor = UIColor.white
        
        print("顺序查找")
        testSearch(searchObject: SequentialSearch())
        
        print("\n折半查找")
        testSearch(searchObject: BinarySearch())
        
        print("\n插值查找")
        testSearch(searchObject: InterpolationSearch())
        
    }
    
    func testSearch(searchObject: SearchType) {
        let items = [1, 2, 3, 4, 5, 6, 8]
        let result = searchObject.search(items: items, item: 6)
        print("result: \(result)")
    }
}

//MARK:- 顺序查找
class SequentialSearch: SearchType {
    func search(items: Array<Int>, item: Int) -> Int {
        for i in 0..<items.count {
            if items[i] == item {
                return i + 1
            }
        }
        return 0
    }
}

//MARK:- 折半查找[有序列表]
class BinarySearch: SearchType {
    func search(items: Array<Int>, item: Int) -> Int {
        var low = 0
        var high = items.count - 1
        while low < high {
            let middle = (high + low) / 2
            
            if item > items[middle] {
                low = middle + 1
            } else if item < items[middle] {
                high = middle - 1
            } else {
                return middle + 1
            }
        }
        return 0
    }
}

//MARK:- 插值查找
class InterpolationSearch: SearchType {
    func search(items: Array<Int>, item: Int) -> Int {
        var low = 0
        var high = items.count - 1
        while low < high {
            let weight = Float(item - items[low]) / Float(items[high] - items[low])
            let middle = low + Int(weight * Float(high - low))
            
            if item > items[middle] {
                high = middle + 1
            } else if item < items[middle] {
                low = middle - 1
            } else {
                return middle + 1
            }
        }
        
        return 0
    }
}

