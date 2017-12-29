//
//  GradientViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/28.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {
    
    private var progressView: CircleGradientProgressView!
    private var percent: CGFloat = 0.1
    
    var gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    func setupUI() {
        landscapeGradient()
        circleGradient()
        textGradient()
        ringGradient()
       
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
        progressView = CircleGradientProgressView(frame: CGRect(x: 0, y: 250, width: ScreenWidth, height: 200))
        view.addSubview(progressView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if percent >= 1.0 {
            percent = 0
        }
        percent += 0.1
        progressView.setupPercent(percent: CGFloat(percent))
    }
    
    //MARK:- 文字渐变
    func textGradient() {
        
        let container = UIView(frame: CGRect(x: 0, y: 500, width: ScreenWidth, height: 100))
        view.addSubview(container)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        titleLabel.textColor = UIColor.black
        container.addSubview(titleLabel)
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = titleLabel.frame
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.3, 0.8]
        container.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.mask = titleLabel.layer
        
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0, 0.2]
        animation.toValue = [0.8, 1, 1]
        animation.duration = 2
        animation.repeatCount = HUGE
        animation.autoreverses = true
        gradientLayer.add(animation, forKey: "locations")
    }
    
    //MARK:- 圆环渐变
    func ringGradient() {
        
        let container = UIView(frame: CGRect(x: 0, y: 600, width: ScreenWidth, height: 100))
        container.backgroundColor = UIColor.lightGray
        view.addSubview(container)
        
        gradientLayer.frame = container.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.blue.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.0)
        container.layer.addSublayer(gradientLayer)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(arcCenter: CGPoint(x: ScreenWidth * 0.5, y: 50), radius: 40, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true).cgPath
        maskLayer.lineCap = kCALineCapRound
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.lightGray.cgColor
        maskLayer.lineWidth = 20
        gradientLayer.mask = maskLayer
        
        performAnimation(gradientLayer: gradientLayer)

    }
    
    func performAnimation(gradientLayer: CAGradientLayer) {
        //更新渐变层的颜色
        let fromColors = gradientLayer.colors as! [CGColor]
        let toColors = shiftColors(colors: fromColors)
        gradientLayer.colors = toColors
        //创建动画实现渐变颜色从左上向右下移动的效果
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = 2
        animation.fromValue = fromColors
        animation.toValue = toColors
        //动画完成后是否要移除
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionLinear)
        animation.delegate = self
        //将动画添加到图层中
        gradientLayer.add(animation, forKey: "colors")
    }
    
    func shiftColors(colors:[CGColor]) -> [CGColor] {
        //复制一个数组
        var newColors: [CGColor] = colors.map{($0.copy()!) }
        //获取最后一个元素
        let last: CGColor = newColors.last!
        //将最后一个元素删除
        newColors.removeLast()
        //将最后一个元素插入到头部
        newColors.insert(last, at: 0)
        //返回新的颜色数组
        return newColors
    }
    
}

extension GradientViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performAnimation(gradientLayer: gradientLayer)
    }
}


/// 进度条渐变
class CircleGradientProgressView: UIView {
    
    private var progressWidth: CGFloat = 8
    private var progressRadius: CGFloat = 80
    
    /// 进度条背景
    private var progressBgLayer: CAShapeLayer!
    private var progressBgColor = UIColor.lightGray
    
    /// 进度条
    private var progressLayer: CAShapeLayer!
    
    //渐变层
    private var gradientLayer: CALayer!
    
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
        
        //分两部分设置渐变层
        let leftGradientLayer = CAGradientLayer()
        leftGradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.5, height: self.frame.size.height)
        leftGradientLayer.colors = [UIColor.yellow.cgColor,
                                 UIColor.green.cgColor,
                                 UIColor.cyan.cgColor,
                                 UIColor.blue.cgColor]
        leftGradientLayer.locations = [0.1, 0.4, 0.6, 1]
        
        
        let rightGradientLayer = CAGradientLayer()
        rightGradientLayer.frame = CGRect(x: self.frame.width * 0.5, y: 0, width: self.frame.width * 0.5, height: self.frame.size.height)
        rightGradientLayer.colors = [UIColor.yellow.cgColor,
                                    UIColor.red.cgColor]
        rightGradientLayer.locations = [0.1, 0.8]
        
        gradientLayer = CALayer()
        gradientLayer.addSublayer(leftGradientLayer)
        gradientLayer.addSublayer(rightGradientLayer)
        gradientLayer.mask = progressLayer
        self.layer.addSublayer(gradientLayer)
        
    }
    
    func setupPercent(percent: CGFloat, animated: Bool = true) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        progressLayer.strokeEnd = percent
        CATransaction.commit()
        
    }
    
}


// MARK: - 横向纵向渐变
extension CAGradientLayer {
    func setupLandscapeGradientLayer(colors: [CGColor], locations: [NSNumber], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 0)) -> CAGradientLayer {
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        return self
    }
}


