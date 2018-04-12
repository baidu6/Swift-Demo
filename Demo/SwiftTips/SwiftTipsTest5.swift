//
//  SwiftTipsTest5.swift
//  Demo
//
//  Created by 王云 on 2018/4/3.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit


enum Result {
    case Success(String)
    case Error(NSError)
}

class SwiftTipsTest5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
         assertTest()
        
        let result = doSomethingParam(param: 3 as AnyObject)
        switch result {
        case let .Success(ok):
            print(ok)
        case let .Error(error):
            print(error)
        }
        
//       Hello.sayHello()
    }
    
    func doSomethingParam(param: AnyObject) -> Result {
        
        if true {
            return Result.Success("成功完成")
        } else {
            let error = NSError(domain: "errorDomain", code: 1, userInfo: nil)
            return Result.Error(error)
        }
    }
    
    func assertTest() {
//        assert(2 > 1, "assert")
//        fatalError("Error")
    }

}
