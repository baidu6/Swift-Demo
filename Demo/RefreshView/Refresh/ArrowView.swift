//
//  ArrowView.swift
//  Demo
//
//  Created by 王云 on 2018/3/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    
    lazy var layerShape: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        self.backgroundColor = UIColor.clear
        let path = UIBezierPath()
        let rect = self.bounds
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        layerShape.lineJoin = kCALineJoinRound
        layerShape.path = path.cgPath
    }
    
}
