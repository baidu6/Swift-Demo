//
//  FunctionalTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/5.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SwiftTipsTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        print(addTo(adder: 10)(2))
        print(graterThan(10)(12))
        
        let arr = [0, 1, 2, 3, 4]
        for i in ReverseSequence(array: arr) {
            print("Index:\(i), \(arr[i])")
        }
        var a = "a"
        var b = "b"
        swap(&a, &b)
        print(a, b)
        
//        logIfTrue({ return 2 < 1 })
//        logIfTrue{ return 2 > 1}
//        logIfTrue { 2 > 1 }
        
        //@autoclosure修饰
        logIfTrue(2 > 1)
        
        let xiaoming = Child()
        let toyName = xiaoming.pet?.toy?.name
        print(toyName)
        let playClosure = { (child: Child) -> () in
            child.pet?.toy?.play()
        }
        playClosure(xiaoming)
        
        let v1 = Vector2D(x: 10, y: 1)
        let v2 = Vector2D(x: 1, y: 10)
        print(v1 +* v2)
        
        print(incrementFunc(variable: 2))
        var num = 3
        incrementor(variable: &num)
        print(num)
        
        let myTrue: MyBool = true
        let myFalse: MyBool = false
        print(myTrue.rawValue, myFalse.rawValue)
        
        let p: PersonClass = "zhangsan"
        print(p.name, type(of: p))
        
        var array = [1, 2, 3, 4, 5]
        print(array[[0, 1, 5]])
        
        array[[0, 1, 2, 3, 4]] = [11, 22, 33, 44, 55]
        print(array[[0, 1, 2, 3, 4]])
    }
}

protocol Food {
    
}
protocol Animal {
    associatedtype F
    func eat(_ food: F)
}
struct Meat: Food {
    
}
struct Grass: Food {
    
}
struct Tigers: Animal {
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat\(food)")
    }
}

//MARK:- 下标【目前Array支持的下标subscript (index: Int) -> T, subscript(subRange: Range<Int>) -> Slice<T>】
//定义一个接受数组作为下标输入的读取方法
extension Array {
    subscript(inputs: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in inputs where i < self.count {
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index, i) in inputs.enumerated() {
                self[i] = newValue[index]
            }
        }
    }
}

//MARK:- 字面量
//想要通过string赋值来生成一个PersonClass对象；
class PersonClass: ExpressibleByStringLiteral {
    let name: String
    init(name value: String) {
        self.name = value
    }
    //在extension中不能定义required初始化方法的
    required init(stringLiteral value: String) {
        self.name = value
    }
}
enum MyBool: Int {
    case myTrue, myFalse
}
extension MyBool: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self = value ? .myTrue : .myFalse
    }
}

//MARK:- 操作符【precedencegroup定义操作符优先级,associativity定义结合律，即如果多个同类的操作符顺序出现的计算顺序；higherThan运算的优先级；infix表示定义的是一个中位操作符，即前后都是熟人，其它修饰符还包括prefix和postfix；】注意：操作符不能定义在局部域中的，因为至少会希望在能在全局范围使用你的操作符，否则操作符也就失去意义了。
precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}
infix operator +*: DotProductPrecedence
func +*(left: Vector2D, right: Vector2D) -> Int {
    return left.x * right.x + left.y * right.y
}

//optional chaining
class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}
extension Toy {
    func play() {
        print("play")
    }
}
class Pet {
    var toy: Toy?
}
class Child {
    var pet: Pet?
}

//MARK:- autoClousure
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}
//MARK:- 多元组Tuple
func swapMe2<T>(a: inout T, b: inout T) {
    (a, b) = (b, a)
}
//MARK:- Sequence
class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = self.array.count - 1
    }
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}
struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}
//MARK:- 将protocol的方法声明为mutating,swift中的mutating关键字修饰方法是为了能够在该方法中修改struct或者是enum的变量；
protocol Vehicle {
    var numberOfWheels: Int { get }
    var color: UIColor { get set}
    mutating func changeColor()
}
//对于class而言是不用添加mutating关键字的
struct MyCar: Vehicle {

    let numberOfWheels = 4
    var color = UIColor.blue
    mutating func changeColor() {
        color = .red
    }
}
//MARK:- 柯里化
extension SwiftTipsTestViewController {
    func addOne(num: Int) -> Int {
        return num + 1
    }
    
    func addTo(adder: Int) -> (Int) -> Int {
        return { num in
            return num + adder
        }
    }
    
    func graterThan(_ compare: Int) -> (Int) -> Bool {
        return { num in
            return num > compare
        }
    }
}

extension SwiftTipsTestViewController {
    func incrementor(variable: inout Int) {
        variable += 1
    }
    
    func incrementFunc(variable: Int) -> Int {
        var num = variable
        num += 1
        return num
    }
}


