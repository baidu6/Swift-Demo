//
//  WKWebViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/17.
//  Copyright © 2018年 王云. All rights reserved.
//


//WKWebView不能够利用JavaScriptCore进行交互
//1、UIWebView拦截URL和WKWebView拦截URL。
//
//2、UIWebView调用JavaScriptCore，JavaScriptCore是iOS7新添加的框架。
//
//3、WKWebView使用WKScriptMessageHandler和Objective-C交互。
//
//4、UIWebView调用WebViewJavascriptBridge和WKWebView调用WebViewJavascriptBridge。

import UIKit
import WebKit

class WKWebViewController: UIViewController {
    
    fileprivate var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    func setupUI() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        configuration.userContentController.add(self, name: "ShowMessageFromWKWebView")
        
        if let path = Bundle.main.path(forResource: "demo", ofType: "html") {
            webView.load(URLRequest(url: URL(fileURLWithPath: path)))
        }
        
       
    }

}

extension WKWebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "ShowMessageFromWKWebView" {
            if let dict = message.body as? [String: Any] {
                showMessage(dict: dict)
            }
        }
    }
    
    func showMessage(dict: [String: Any]) {
        let alertVC = UIAlertController(title: "Hello!", message: "我的名字是\(dict["name"] ?? ""), 我的年龄是\(dict["age"] ?? 0), 我的工作是\(dict["job"] ?? "")", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension WKWebViewController: WKUIDelegate {
    //MARK:- webView中有警告框时候调用
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //MARK:- webView关闭时候调用
    func webViewDidClose(_ webView: WKWebView) {
        print("webViewDidClose")
    }
}

extension WKWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        webView.evaluateJavaScript("var param = document.getElementById('param'); param.innerHTML = '被你修改了。'") { (_, error) in
            print(error)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString {
            if urlString.hasPrefix("wy://") {
                
                if let stringIndex = urlString.index(of: "?"), urlString[..<stringIndex] == "wy://clickMe" {
                    let startIndex = urlString.index(after: stringIndex)
                    let string = urlString[startIndex...]
                    let json = String(string).toJSONString()
                    let dict = json.toUrlDecode()?.toDictionary()
                    print(dict)

                }
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            }
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}


