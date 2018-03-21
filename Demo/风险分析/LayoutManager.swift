//
//  LayoutManager.swift
//  GXD
//
//  Created by PlutusCat on 2017/10/23.
//  Copyright © 2017年 智慧估价. All rights reserved.
//

import UIKit


//MARK:- 屏幕宽度
public let SCREEN_WIDTH = UIScreen.main.bounds.width

//MARK:- 屏幕高度
public let SCREEN_HEIGHT = UIScreen.main.bounds.height

//MARK:- Cell 默认高度
public let cellHeight = autoHeight(height: 110)

//MARK:-  屏幕适配
let StandardWidth:CGFloat = 750.0
let StandardHeight:CGFloat = 1334.0

func autoX(X: CGFloat) -> CGFloat {
    return X/StandardWidth*SCREEN_WIDTH
}

func autoY(Y: CGFloat) -> CGFloat {
    return Y/StandardHeight*SCREEN_HEIGHT
}

func autoWidth(width: CGFloat) -> CGFloat {
    return width/StandardWidth*SCREEN_WIDTH
}

func autoHeight(height: CGFloat) -> CGFloat {
    return height/StandardHeight*SCREEN_HEIGHT
}

func autoFont(size: CGFloat) -> CGFloat {
    return size/StandardWidth*SCREEN_WIDTH
}
