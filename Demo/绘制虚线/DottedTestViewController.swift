//
//  DottedTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/6/20.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class DottedTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let view1 = UIView(frame: CGRect(x: 50, y: 100, width: 300, height: 30))
        view1.backgroundColor = UIColor.red
        view1.drawDashLine(strokeColor: UIColor.black)
        view.addSubview(view1)
        
    }

}

extension UIView {
    //MARK:- 绘制虚线
    func drawDashLine(strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5, isBottom: Bool = true) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        let y = isBottom == true ? self.layer.bounds.height - lineWidth : 0
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: self.layer.bounds.width, y: y))
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}
