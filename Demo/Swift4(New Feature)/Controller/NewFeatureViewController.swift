//
//  NewFeatureViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/12.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class NewFeatureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let numberSet = Set(1...100)
        let evens = numberSet.filter({$0 % 2 == 0})
        print(evens)
        let numbers = ["one": 1, "two": 3, "three": 4, "four": 5]
        let dict = Dictionary(uniqueKeysWithValues: numbers.map({ (key: $0.0, value: $0.1 + 10) }))
        print(dict)
        
    }

}

class Foo {
    var bar = "bar"
    var baz = [1, 2, 3, 4]
}
