//
//  AlamofireViewController.swift
//  Demo
//
//  Created by 王云 on 2018/5/8.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Alamofire


class AlamofireViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        getTestFunction()
        postTestFunction()
    }
    
    //MARK:- GET请求
    func getTestFunction() {
        
        NetWorkTool.HttpGet("https://httpbin.org/get", params: nil) { (response) in
            print(response)
        }
    }
    
    //MARK:- POST请求
    func postTestFunction() {
        
        let params: [String: Any] = ["name": "wangyun", "hobby": "sleeping"]
        NetWorkTool.HttpPost("https://httpbin.org/post", params: params) { (response) in
            print(response)
        }
       
    }
    

}
