//
//  Public.swift
//  Demo
//
//  Created by 王云 on 2018/5/9.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

let Debug = true

//控制域名
let DebugHost: Bool = {
    return true && Debug
}()

//控制日志
let DebugLog: Bool = {
    return true && Debug
}()

typealias DictionaryDefault = Dictionary<String, Any>

typealias SimpleCallBackWithDic = (_ dict: DictionaryDefault?) -> Void
