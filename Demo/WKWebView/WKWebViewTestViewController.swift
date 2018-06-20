//
//  WKWebViewTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/6/11.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewTestViewController: UIViewController {
    
    private var webView: WKWebView!
    
    private lazy var progrssView: UIProgressView = {
        let view = UIProgressView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 3))
        view.backgroundColor = UIColor.white
        view.progressTintColor = UIColor.red
        view.tintColor = UIColor.blue
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)
        
        
        let request = URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "hello.html", ofType: nil)!))
        webView.load(request)
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        //获取title 进度条
        webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        //添加js的方法ClickMe
        webView.configuration.userContentController.add(self, name: "ClickMe")
        
    }
    
    deinit {
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "ClickMe")
        print("WKWebViewTestViewController -- deinit")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            print(change?[NSKeyValueChangeKey(rawValue: "new")])
        } else if keyPath == "estimatedProgress" {
            if let progress = change?[NSKeyValueChangeKey(rawValue: "new")] as? Float {
                self.progrssView.setProgress(progress, animated: true)
            }
        }
    }

}



extension WKWebViewTestViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "ClickMe" {
            print(message.body)
        }
    }
}

extension WKWebViewTestViewController: WKUIDelegate {

    //MARK:- 网页执行alert的时候调用
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (_) in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- js中的confirm确定框, 在completionHandler中用户选择返回
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void) {
        print(message)
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (_) in
            completionHandler(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- js中的prompt输入弹出框，completionHandler将输入信息返回
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Swift.Void) {
        print(prompt, defaultText)
        completionHandler(nil)
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("webViewDidClose")
    }
}

extension WKWebViewTestViewController: WKNavigationDelegate {
    
    //MARK:- 页面开始加载时候调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("页面开始加载")
    }
    //MARK:- 当内容开始返回的时候调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("开始返回内容")
    }
    //MARK:- 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("页面加载完成")
        // swift 调用js
        let js = "document.getElementsByName('input')[0].style.display = 'block';"
        webView.evaluateJavaScript(js) { (response, error) in
            print("response: \(response)")
            print("error: \(error)")
        }
    }
    //MARK:- 页面加载失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("页面加载失败")
    }
    
    //MARK:- 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if let urlString = navigationAction.request.url?.absoluteString {
            print(urlString)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    //MARK:- 在收到响应后 决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        print(navigationResponse.response.url?.absoluteString)
        decisionHandler(WKNavigationResponsePolicy.allow)   //允许跳转
//        decisionHandler(WKNavigationResponsePolicy.cancel)  //不允许跳转
    }
}
