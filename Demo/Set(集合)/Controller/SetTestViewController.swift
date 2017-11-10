//
//  SetTestViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/10.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class SetTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "集合类"

        arrayTest()
        dictTest()
        setTest()
    }
    
    func arrayTest() {
        var array:[Int] = [1, 2, 3, 4, 5]
        
        for (index, value) in array.enumerated() {
            print(index,value)
        }
        
        array += [10]
        
        print(array)
        
        let result = array.dropFirst()
        print(result)
        
        let result1 = array.prefix(2)
        print(result1)
        
        let result2 = array.suffix(2)
        print(result2)
        
        let result3 = array.dropLast(1)
        print(result3)
        
        let result4 = array.split(whereSeparator: { $0 % 2 == 0})
        print(result4)
        
        let result5 = array.myMap(transform: {$0 + 100})
        print(result5)
        
        let result6 = Array(repeatElement(3, count: 3))
        print(result6)
        
        //数组是否为空
        print(array.isEmpty)
        //seperator以xxx分割打印，terminator以xxx结尾打印
        print(array,result5, separator: "----", terminator: ")))))")
        
        array.append(contentsOf: [100, 200, 3000])
        print(array)
        array.insert(contentsOf: [5, 5, 5], at: 1)
        print(array)
    }
    
    func dictTest() {
        var dict = [200: "OK",
                    403: "Access forbidden",
                    404: "File not found",
                    500: "Internal servel error"
                    ]
        //如果key对应数值为空，那么这个key也将会被删除
        dict[500] = nil
        print(dict)
        
        
        var numbers = ["number1": [1, 3, 5, 6, 2, 4],
                       "number2": [3, 5, 1, 44, 22,2],
                       "number3": [89, 67, 34, 23]
                       ]
        for key in numbers.keys {
            numbers[key]?.sort(by: >)
        }
        print(numbers)
        
        let index = numbers.index(where: { $0.value.contains(5)})
        if let index = index {
            print("\n\(numbers[index])")
        }
        
        numbers["number4"] = [33,33,333,33]
        print(numbers)
        
        numbers["number4"] = nil
        print(numbers)
    }
    
    func setTest() {
        print("\n----------------")
        let set1: Set = ["zhangsan", "lisi", "zhaoliu", "wangwu", "xiaogou"]
        let set2: Set = ["zhangsan", "lisi", "zhaoliu", "wangwu", "xiaogou"]
        let set3: Set = ["lisi", "zhaoliu", "wangwu", "xiaogou"]
        let set4: Set = ["top", "left", "xiaogou"]
        
        //Use the contains(_:) method to test whether a set contains a specific element.
        if set1.contains("xiaogou") {
            if let index = set1.index(of: "xiaogou") {
                print(index)
            }
        }
        
        //Use the “equal to” operator (==) to test whether two sets contain the same elements.
        if set2 == set1 {
            print("whether two sets contain the same elements")
        }
        
        //Use the isSubset(of:) method to test whether a set contains all the elements of another set or sequence
        if set2.isSubset(of: set1) {
            print("a set contains all the elements of another set or sequence")
        }
        
        //Use the isSuperset(of:) method to test whether all elements of a set are contained in another set or sequence.
        if set1.isSuperset(of: set2) {
            print("all elements of a set are contained in another set or sequence")
        }
        
        //Use the isStrictSubset(of:) and isStrictSuperset(of:) methods to test whether a set is a subset or superset of, but not equal to, another set.
        if set3.isStrictSubset(of: set1) {
            print("set3 isStrictSubset")
        }
        
        
//        //Use the isDisjoint(with:) method to test whether a set has any elements in common with another set
//        if set4.isDisjoint(with: set1) {
//            print("set1 has any elements in common with set4")
//        }
        
        //Use the union(_:) method to create a new set with the elements of a set and another set or sequence
        print(set4.union(set1))
        
        //Use the intersection(_:) method to create a new set with only the elements common to a set and another set or sequence.
        print(set1.intersection(set4))
        
        //Use the symmetricDifference(_:) method to create a new set with the elements that are in either a set or another set or sequence, but not in both.
        print(set4.symmetricDifference(set1))
        
        //Use the subtracting(_:) method to create a new set with the elements of a set that are not also in another set or sequence.
        print(set4.subtracting(set1))
        
    }
}

extension Array {
    func myMap<T>(transform: (_ value: Element) -> T) -> [T] {
        var result:[T] = [T]()
        for value in self {
            result.append(transform(value))
        }
        return result
    }
}
