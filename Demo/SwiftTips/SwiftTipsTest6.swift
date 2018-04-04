//
//  SwiftTipsTest6.swift
//  Demo
//
//  Created by 王云 on 2018/4/3.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

struct Obj: Codable {
    let menu: Menu
    struct Menu: Codable {
        let id: String
        let value: String
        let popup: Popup
    }
}

struct Popup: Codable {
    let menuItems: [MenuItem]
    enum CodingKeys: String, CodingKey {
        case menuItems = "menuitem"
    }
}

struct MenuItem: Codable {
    let value: String
    let onClick: String
    enum CodingKeys: String, CodingKey {
        case value
        case onClick = "onclick"
    }
}

class SwiftTipsTest6: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
   
        let jsonString = "{\"menu\": {\"id\": \"file\", \"value\": \"File\", \"popup\": {\"menuitem\": [{\"value\": \"New\", \"onclick\": \"CreateNewDoc()\"}, {\"value\": \"Open\", \"onclick\": \"OpenDoc()\"}, {\"value\": \"Close\", \"onclick\": \"CloseDoc()\"}]}}}"
        let data = jsonString.data(using: .utf8)!
        do {
            let obj = try JSONDecoder().decode(Obj.self, from: data)
            let value = obj.menu.popup.menuItems[0].onClick
            print(value)
        } catch {
            print("出错了\(error)")
        }
        
        printLog("这是一条输出")
    }
    
    func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method): \(message)")
        #endif
    }
}
