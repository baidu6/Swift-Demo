//
//  InitTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/23.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

/**
 swift的初始化方法需要保证类型的所有属性都被初始化；
 需要保证当前子类所有的实例成员初始化完成后才能够调用父类的初始化方法；
通过添加required关键字进行限制，强制子类对这个方法重新实现；
 
 原则：
 1.初始化路径必须保证对象完全初始化，这可以通过调用本类型的designated初始化方法来得到保证；
 2.子类的dedignated初始化方法必须调用父类的designated方法，以保证父类也完成初始化；
 */

class InitTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

}

class AnimalClass {
    var name: String
    init() {
        name = "Animal"
    }
}
class CatClass: AnimalClass {
    let power: Int
    var age: Int?
    override init() {
        
        //1.0 设置子类自己需要初始化的参数
        power = 10
        //1.1 调用父类响应的初始化方法
        super.init()
        //1.2 若要改变父类中变量的值
        name = "Cat"
    }
}

class TitileView: UIView {
    var title: String?
    var titleLabel: UILabel!

    //required 修饰 子类必须重写
    required init(title: String) {
        super.init(frame: CGRect.zero)
    }
    
    /*
    所有的convenience初始化方法都必须调用同一个类中的designated初始化完成设置；
    convenience的初始化方法是不能被子类重写或者是从子类中以super的方式被调用的；
    只要在子类中实现重写了父类方法所需要的init方法的话，在子类中可以使用父类的convenience初始化方法了；
    可以用required修饰 确保子类能够使用；
    */
    required convenience init(big: Bool) {
        self.init(title: big ? "big" : "samll")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetailView: TitileView {
    var detail: String?
    var detailLabel: UILabel!
    
    required init(title: String) {
        super.init(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 初始化返回为nil
extension Int {
    init?(fromString: String) {
        self = 0
        switch fromString {
        case "1":
            self = 1
        default:
            return nil
        }
    }
}
