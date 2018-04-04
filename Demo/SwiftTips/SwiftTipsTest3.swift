//
//  SwiftTipsTest3.swift
//  Demo
//
//  Created by 王云 on 2018/3/23.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
//Swift中常用的原生容器类型有三种： Array， Dictionary，Set；
class SwiftTipsTest3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let mixed: [CustomStringConvertible] = [1, "two", 3]
        for obj in mixed {
            print(obj.description)
        }
        
        sayHello1(str2: "Jemy", str3: "World")
        sayHello2(str1: "Tom", str2: "Sun")
    }

}

//MARK:- default 参数
extension SwiftTipsTest3 {
    func sayHello1(str1: String = "Hello", str2: String, str3: String) {
        print(str1 + str2 + str3)
    }
    //MARK:- 其它不少语言只支持这一种写法，将默认参数作为方法的最后一个参数
    func sayHello2(str1: String, str2: String, str3: String = "World") {
        print(str1 + str2 + str3)
    }
}

//MARK:- 正则表达式【正则表达式是一种文本模式，包括a到z的英文字母 和 特殊字符(称为元字符);】
/**
 1. ^ 匹配字符串的开始位置；
 2. + 匹配一个或者多个；
 3. $ 匹配输入字符串的结束位置；
 4. * 前面的字符可以出现，也可以不出现（0次，1次，或多次）；
 5. ? 前面的字符最多只可以出现一次（0次，或1次）；
 6. ()标记一个子表达式的开始和结束位置；
 7. [ 标记一个中括号表达式的开始；
 8. \ 将下一个字符标记为或特殊字符，原义字符，向后引用，八进制转义符；
 9. { 标记限定符表达式的开始；
 10. | 指明两项之间的一个选择；
 11. 6中限定符：{
                *,
                +,
                ?,
                {n}, n 是非负整数，匹配确定的n次；
                {n,}, n是非负整数，至少匹配n次；
                {n,m} n, m都是非负整数，至少匹配n次，最多匹配m次
               }；
 12. .匹配除了\r,\n之外的任何单个字符；
 13. \\w 匹配字母或数字或下划线或汉字； \\W 匹配任意不是字母，数字，下划线，汉字的字符；
 14. \\s 匹配任意的空白符；      \\S 匹配任意不是空白符的字符；
 15. \\d 匹配数字；      \\D 匹配任意非数字的字符；
 16. \\b 匹配单词的开始或者结束；   \\B  匹配不是单词开头或结束的位置；
 17. [^x] 匹配除了x以外的任意字符， [^aeiou] 匹配除了aeiou这几个字母以外的任意字符；
 18. *? 重复任意次，但尽可能少重复；
 19. +? 重复1次或更多次，但尽可能少重复；
 20. ?? 重复0次或1次，但尽可能少重复；
 21. {n,m}? 重复n到m次，但尽可能少重复；
 22. {n,)? 重复n次以上，但尽可能少重复；
 23. \\a 报警字符；
 24. \\b 通常是单词分界位置，但如果在字符串里使用代表退格；
 25. \\t 制表符，Tab；
 26. \\r 回车；
 27. \\v 竖向制表符；
 28. \\f 换页符；
 29. \\n 换行符；
 30. \\e Escape；
 */
extension SwiftTipsTest3 {
    
}

