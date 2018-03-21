//
//  PackageManager.swift
//  GXD
//
//  Created by PlutusCat on 2017/6/20.
//  Copyright © 2017年 智慧估价. All rights reserved.
//

import UIKit

class PackageManager: NSObject {


/*
  MARK:- 快捷创建圆角
 */
    class func makeRounded(view: UIView, corner: CGFloat) -> UIView {
        
        view.layer.cornerRadius = corner
        view.layer.masksToBounds = true

        return view
    }

/*
  MARK:- 快捷设置图片不拉神
 */
    class func makeAspectFill(imageView: UIImageView) -> UIImageView {

        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView

    }

/*
  MARK:- 设置阴影
 */
    class func makeShadow(view: UIView, radius: CGFloat) -> UIView {

        view.layer.masksToBounds = false
        view.layer.cornerRadius = radius
        view.layer.shadowOffset =  CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor

        return view

    }

/*
    MARK:- 设置阴影 + 阴影颜色
*/
    class func makeShadowWithColor(view: UIView, radius: CGFloat, color: UIColor) -> UIView {

        view.layer.masksToBounds = false
        view.layer.cornerRadius = radius
        view.layer.shadowOffset =  CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = color.cgColor

        return view
        
    }
    
    //MARK:- 切角【上半部分】
    class func makeTopRoundRadius(view: UIView, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = view.bounds
        layer.path = path.cgPath
        view.layer.mask = layer
    }
    
    //MARK:- 切角【下半部分】
    class func makeBottomRoundRadius(view: UIView, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = view.bounds
        layer.path = path.cgPath
        view.layer.mask = layer
    }
    
    class func makeRoundRadius(view: UIView, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = view.bounds
        layer.path = path.cgPath
        view.layer.mask = layer
    }


}
