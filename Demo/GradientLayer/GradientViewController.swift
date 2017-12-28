//
//  GradientViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/28.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    func setupUI() {
//        landscapeGradient()
        circleGradient()
       
    }

    //MARK:- 横向(纵向)渐变
    func landscapeGradient() {
        //MARK:- 横向纵向渐变
        let colors = [UIColor.yellow.withAlphaComponent(0.4).cgColor, UIColor.red.withAlphaComponent(0.8).cgColor, UIColor.orange.withAlphaComponent(0.8).cgColor]
        let locations: [NSNumber] = [0.0, 0.5, 1.0]
        
//        //横向渐变
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        let gradientLayer = CAGradientLayer().setupLandscapeGradientLayer(colors: colors, locations: locations)
        gradientLayer.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: 150)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK:- 进度条渐变
    func circleGradient() {
        let progressView = CircleGradientProgressView(frame: CGRect(x: 0, y: 250, width: ScreenWidth, height: 200))
        view.addSubview(progressView)
    }
   

}

class CircleGradientProgressView: UIView {
    
    private var progressWidth: CGFloat = 8
    private var progressRadius: CGFloat = 80
    
    /// 进度条背景
    private var progressBgLayer: CAShapeLayer!
    private var progressBgColor = UIColor.lightGray
    
    /// 进度条
    private var progressLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5), radius: progressRadius, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        
        //进度条背景
        progressBgLayer = CAShapeLayer()
        progressBgLayer.frame = self.bounds
        progressBgLayer.fillColor = UIColor.clear.cgColor
        progressBgLayer.strokeColor = progressBgColor.cgColor
        progressBgLayer.opacity = 0.25
        progressBgLayer.lineCap = kCALineCapRound
        progressBgLayer.lineWidth = progressWidth
        progressBgLayer.path = path.cgPath
        self.layer.addSublayer(progressBgLayer)
        
        //进度条
        progressLayer = CAShapeLayer()
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.lineWidth = progressWidth
        progressLayer.path = path.cgPath
        //进度条默认结束位置是0
        progressLayer.strokeEnd = 0
        self.layer.addSublayer(progressLayer)
        
    }
    
}

extension CAGradientLayer {
    func setupLandscapeGradientLayer(colors: [CGColor], locations: [NSNumber], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 0)) -> CAGradientLayer {
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        return self
    }
}
