//
//  SortedViewController.swift
//  Demo
//
//  Created by 王云 on 2018/7/2.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

protocol SortedType {
    func sort(items: Array<Int>) -> Array<Int>
}

class SortedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "排序"
    }

}

//MARK:- 冒泡排序
class BubbleSort: SortedType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("冒泡排序")
        var list = items
        for i in 0..<list.count {
            var j = list.count - 1
            while j > i {
                if list[j - 1] > list[j] {
                    let temp = list[j]
                    list[j] = list[j - 1]
                    list[j - 1] = temp
                }
            }
            j = j - 1
        }
        return list
    }
}

//MARK:- 插入排序
class InsertSort: SortedType {
    func sort(items: Array<Int>) -> Array<Int> {
        var list = items
        for i in 0..<list.count {
            var j = i
            while j > 0 {
                if list[j] < list[j - 1] {
                    let temp = list[j]
                    list[j] = list[j - 1]
                    list[j - 1] = temp
                    j = j - 1
                } else {
                    break
                }
            }
        }
        return list
    }
}
