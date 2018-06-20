//
//  NetWorkTool.swift
//  Demo
//
//  Created by 王云 on 2018/5/9.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Alamofire

class NetWorkTool: NSObject {
    
    static let URL_Host_Develop = ""
    static let URL_Host_Release = ""
    
    static var URL_Host: String = {
        return DebugHost ? URL_Host_Develop : URL_Host_Release
    }()
    
    private static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    @discardableResult
    static func HttpGet(_ url: String, isAbsolute: Bool = false, params: DictionaryDefault?, header: Dictionary<String, String>? = nil, completionHandler: SimpleCallBackWithDic?) -> Request {
        
        let parseResult = parseUrlAndParams(url, isAbsolute: isAbsolute, params: params)
        if DebugLog {
            print("请求的URL=========================\n\(parseResult.url)\n请求的参数\n==========================\(String(describing: parseResult.params))")
        }
        
       return manager.request(parseResult.url, method: .get, parameters: parseResult.params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            completionHandler?(parse(response: response))
        }
    }
    
    @discardableResult
    static func HttpPost(_ url: String, isAbsolute: Bool = false, params: DictionaryDefault?, header: Dictionary<String, String>? = nil, completionHandler: SimpleCallBackWithDic?) -> Request {
        let parseResult = parseUrlAndParams(url, isAbsolute: isAbsolute, params: params)
        if DebugLog {
            print("请求的URL=========================\n\(parseResult.url)\n请求的参数\n=====String(describing: ==================)===\(String(describing: parseResult.params))")
        }
        
        return manager.request(parseResult.url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
            completionHandler?(parse(response: response))
        })
    }
    
    private static func parse(response: DataResponse<Any>) -> DictionaryDefault? {
        if response.data == nil {
            print("网络错误，没有返回数据")
        }
        let dic = response.result.value as? DictionaryDefault
        if dic == nil {
            print("response=======\(String(describing: response.result.error))")
        } else {
            print("response=============================\(String(describing: dic))")
        }
        return dic
    }
    
    private static func parseUrlAndParams(_ url: String, isAbsolute: Bool, params: DictionaryDefault?) -> (url: String, params: DictionaryDefault?) {
    
        var url = url
        if !isAbsolute {
            url = URL_Host + url
        }
        
        var p = params
        if p == nil {
            p = Dictionary<String, Any>()
        }
        if let infoDictionary = Bundle.main.infoDictionary {
            //APP名字
            let appDisplayName = infoDictionary["CFBundleDisplayName"] as! String
            //APP版本号
            let appVersion = infoDictionary["CFBundleShortVersionString"] as! String
            //APP Build号
            let appBuildVersion = infoDictionary["CFBundleVersion"] as! String
            //系统版本号
            let systemVersion = UIDevice.current.systemVersion
            
            p!["appDisplayName"] = appDisplayName
            p!["appBuildVersion"] = appBuildVersion
            p!["appVersion"] = appVersion
            p!["systemVersion"] = systemVersion
        }
        return (url, p)
    }
    
}
