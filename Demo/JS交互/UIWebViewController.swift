//
//  JSViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/16.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit

@objc protocol SwiftJavaScriptDelegate: JSExport {
    
    //js调用APP的微信支付功能，演示最基本的用法
    func wxPay(_ orderNo: String)
    
    //js调用APP的微信分享功能，演示字典参数的使用
    func wxShare(_ dict: [String: Any])
    
    //js调用APP方法时传递多个参数，并弹出对话框
    func showDialog(_ title: String, _ message: String)
    
    //js调用APP的功能后 APP再调用js的功能
    func callHandler(_ handleFuncName: String)
}

@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate {
    
    var controller: UIViewController?
    var jsContext: JSContext?
    
    func wxPay(_ orderNo: String) {
        print("订单号\(orderNo)")
    }
    
    func wxShare(_ dict: [String : Any]) {
        print("分享信息\(dict)")
    }
    
    func showDialog(_ title: String, _ message: String) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func callHandler(_ handleFuncName: String) {
        let jsHandlerFunc = jsContext?.objectForKeyedSubscript("\(handleFuncName)")
        let dict: [String : Any] = ["name": "Jack", "age": 20]
        let _ = jsHandlerFunc?.call(withArguments: [dict])
    }
}

class UIWebViewController: UIViewController {
    
    private var webView: UIWebView!
    fileprivate var jsContext: JSContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        testJSContext()
        addWebView()
    }
    
    
    //MARK:- Swift通过JSContext调用JS代码
    func testJSContext() {
        let context = JSContext()
        let result = context?.evaluateScript("1 + 3")
        print(result)
        
        //定义变量和函数
        context?.evaluateScript("var num1 = 50; var num2 = 10;")
        context?.evaluateScript("function sum(param1, param2) { return param1 + param2; }")
        let result2 = context?.evaluateScript("sum(num1, num2);")
        print(result2?.toString())
        
        
        //通过下标来获取js方法并调用方法
        let squareFunc = context?.objectForKeyedSubscript("sum")
        let result3 = squareFunc?.call(withArguments: [10, 30]).toString()
        print(result3)
        
    }
    
    func addWebView() {
        webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        view.addSubview(webView)
        
        if let path = Bundle.main.path(forResource: "demo", ofType: "html") {
            webView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
        }
    }

}

extension UIWebViewController: UIWebViewDelegate {
    
    //JavaScriptCore
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext {
            self.jsContext = context
        }
        
        let model = SwiftJavaScriptModel()
        model.jsContext = self.jsContext
        model.controller = self
        
        //这一步将SwiftJavaScriptModel模型注入到JS中，在JS中通过WebViewJavaScriptBridge调用我们暴露的方法
        self.jsContext.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as NSCopying & NSObjectProtocol)
        
        //注册到本地的html页面中
        if let url = Bundle.main.url(forResource: "demo", withExtension: "html") {
            self.jsContext.evaluateScript(try? String(contentsOf: url, encoding: String.Encoding.utf8))
        }
        
        self.jsContext.exceptionHandler = { (context, exception) in
            print("exception：", exception as Any)
        }
       
    }
    
    //拦截URL
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let urlString = request.url?.absoluteString {
            print(urlString)
            
            if urlString.hasPrefix("wy://") {
                
                if let stringIndex = urlString.index(of: "?"), urlString[..<stringIndex] == "wy://clickMe" {
                    let startIndex = urlString.index(after: stringIndex)
                    let string = urlString[startIndex...]
                    let json = String(string).toJSONString()
                    let dict = json.toUrlDecode()?.toDictionary()
                    print(dict)
                    
//                    showPersonalInfo(info: urlStringtoParams(urlString))
                }
                return false
            }
        }
        
        return true
    }
    
   
    
    func showPersonalInfo(info: [String: Any]?) {

        let alertVC = UIAlertController(title: "Hello", message: "我的名字是\(info?["name"] ?? ""), 我的年龄是\(info?["age"] ?? "")", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //MARK:- 将URl字符串转成字典
    func urlStringtoParams(_ urlString: String) -> [String: Any]? {
        // 1 保存参数
        var url_array = [""]
        // 2 内容中是否存在?或者//
        if urlString.contains("?") {
            url_array = urlString.components(separatedBy:"?")
        }else if urlString.contains("//") {
            url_array = urlString.components(separatedBy: "//")
        }else {
            return nil
        }
        
        // 3 多个参数，分割参数
        let urlComponents = url_array[1].components(separatedBy: "&")
        // 4 保存返回值
        var params = [String: Any]()
        // 5 遍历参数
        for keyValuePair in urlComponents {
            // 5.1 分割参数 生成Key/Value
            let pairComponents = keyValuePair.components(separatedBy:"=")
            // 5.2 获取数组首元素作为key
            let key = pairComponents.first?.removingPercentEncoding
            // 5.3 获取数组末元素作为value
            let value = pairComponents.last?.removingPercentEncoding
            // 5.4 判断参数是否是数组
            if let key = key, let value = value {
                // 5.5 已存在的值，生成数组
                if let existValue = params[key] {
                    // 5.8 如果是已经生成的数组
                    if var existValue = existValue as? [Any] {
                        // 5.9 把新的值添加到已经生成的数组中去
                        existValue.append(value)
                        params[key] = existValue
                    } else {
                        // 5.7 已存在的值，先将他生成数组
                        params[key] = [existValue, value]
                    }
                } else {
                    // 5.6 参数是非数组
                    params[key] = value
                }
            }
        }
        return params
    }
}

extension String {
    
    func toJSONString() -> String {
        return self
            .replacingOccurrences(of: "%7B", with: "{")
            .replacingOccurrences(of: "%7b", with: "{")
            .replacingOccurrences(of: "%7D", with: "}")
            .replacingOccurrences(of: "%7d", with: "}")
            .replacingOccurrences(of: "%5B", with: "[")
            .replacingOccurrences(of: "%5b", with: "[")
            .replacingOccurrences(of: "%5D", with: "]")
            .replacingOccurrences(of: "%5d", with: "]")
            .replacingOccurrences(of: "%22", with: "\"").replacingOccurrences(of: "%20", with: "")
    }
    
    func toUrlDecode() -> String? {
        let result = self.replacingOccurrences(of: "+", with: " ")
        return result.removingPercentEncoding
    }
    
    func toDictionary() -> DictionaryDefault? {
        if let data = self.data(using: String.Encoding.utf8) {
            let dic = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return dic as? DictionaryDefault
        }
        return nil
    }
}
