//
//  RefreshFooterViewDefault.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class RefreshFooterViewDefault: RefreshFooterViewBase {
    var label: UILabel!
    var arrow: ArrowView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func config() {
        super.config()
        let width: CGFloat = 14
        let x = self.frame.size.width * 0.47
        let y = self.frame.size.height * 0.5
        arrow = ArrowView(frame: CGRect(x: x - 3 - width, y: y - width * 0.5, width: width, height: width))
        arrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.addSubview(arrow)
        
        activityIndicator = UIActivityIndicatorView(frame: arrow.frame)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.addSubview(activityIndicator)
        
        label = UILabel(frame: CGRect(x: x + 3, y: 0, width: self.frame.size.width * 0.5, height: self.frame.size.height))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        label.textAlignment = NSTextAlignment.left
        label.text = strPullToRefresh
        self.addSubview(label)
    }
    
    override func onNoneFromRefreshing() {
        super.onNoneFromRefreshing()
        label.text = strPullToRefresh
        activityIndicator.stopAnimating()
        arrow.transform =  CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        arrow.isHidden = false
    }
    
    override func onNormalFromRelease() {
        super.onNormalFromRelease()
        label.text = strPullToRefresh
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
    }
    
    override func onRefreshing() {
        super.onRefreshing()
        label.text = strRefreshing
        activityIndicator.startAnimating()
        arrow.isHidden = true
    }
    
    override func onReleaseFromNormal() {
        super.onReleaseFromNormal()
        label.text = strReleaseToRefresh
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.arrow.transform = CGAffineTransform.identity
        })
    }
}
