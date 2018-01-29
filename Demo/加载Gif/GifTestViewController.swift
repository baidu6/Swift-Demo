//
//  GifTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/29.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class GifTestViewController: UIViewController {
    
    private var webView: UIWebView!
    private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
//        setupWebView()
        setupImageView()
    }
}

//MARK:- 使用UIWebView加载本地gif图片
extension GifTestViewController {
    func setupWebView() {
        webView = UIWebView(frame: view.bounds)
        webView.scrollView.isScrollEnabled = false
        view.addSubview(webView)
        
        let path = Bundle.main.path(forResource: "gif01", ofType: ".gif")
        if let path = path {
            let data = try? Data.init(contentsOf: URL(fileURLWithPath: path))
            webView.load(data!, mimeType: "image/gif", textEncodingName: "", baseURL: URL(fileURLWithPath: path))
        }
    }
}
//MARK:- 用imageView加载gif图片
extension GifTestViewController {
    func setupImageView() {
        imageView = UIImageView(frame: CGRect(x: (ScreenWidth - 200) * 0.5, y: 0, width: 200, height: 200))
        view.addSubview(imageView)
        
//        //创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
//        var imagesArray: [UIImage]?
//
//        imageView.animationImages = imagesArray
//        imageView.animationDuration = 2.0
//        imageView.animationRepeatCount = 0
//        imageView.startAnimating()
        
        guard let path = Bundle.main.path(forResource: "gif01", ofType: ".gif"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)), let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return
        }
        
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        for i in 0..<CGImageSourceGetCount(imageSource) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            i == 0 ? imageView.image = image : ()
            images.append(image)
            
            guard let properties = CGImageSourceCopyProperties(imageSource, nil) as? Dictionary<String, Any>, let gifDict = properties[kCGImagePropertyGIFDictionary as String] as? Dictionary<String, Any>, let frameDuration = gifDict[kCGImagePropertyGIFDelayTime as String] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
     
    }
}
