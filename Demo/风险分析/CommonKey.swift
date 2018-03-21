//
//  CommonKey.swift
//  GXD
//
//  Created by PlutusCat on 2017/6/14.
//  Copyright © 2017年 智慧估价. All rights reserved.
//

import UIKit

//MARK:- 字体名称 苹方-简
////MARK:-  细体
//let Font_Light = "PingFangSC-Light"
////MARK:-  纤细体
//let Font_Thin = "PingFangSC-Thin"
////MARK:-  中黑体
//let Font_Medium = "PingFangSC-Medium"

public let Font_Regular = "PingFangSC-Regular"
//MARK:-  细体
public let Font_Light = "PingFangSC-Light"
//MARK:-  纤细体
public let Font_Thin = "PingFangSC-Light"
//MARK:-  中黑体
public let Font_Medium = "PingFangSC-Medium"
//MARK:-  中粗体
public let Font_Bold = "PingFangSC-Semibold"

//MARK:-  数字
public let Font_Digital = "Arial-BoldMT"

//MARK:-  平方米单位
public let SquareString = "㎡"
public let UnitString = "元/㎡"

public let select_icon = "Single_Select_Icon"
public let disSelect_icon = "Single_DisSelect_Icon"

//MARK:- tableview 标签 分页偏移量
public let pageContentOffset: CGFloat = -120

//MARK:- apple ID
public let MSC_AppID = "5a3ccd64"


//MARK:- 版本信息
public let SYSTEM_VERSION = UIDevice.current.systemVersion
public let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
public let APP_Build_VERSION = Bundle.main.infoDictionary!["CFBundleVersion"]
public let DEVICE_NAME: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPhone9,1":                               return "iPhone 7"
    case "iPhone9,2":                               return "iPhone 7 Plus"
    case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
    case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
    case "iPhone10,3", "iPhone10,6":                return "iPhone X"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,7", "iPad6,8":                      return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
}()

