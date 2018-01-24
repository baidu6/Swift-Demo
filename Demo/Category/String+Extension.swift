//
//  String+Extension.swift
//  Demo
//
//  Created by 王云 on 2018/1/23.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
extension String {
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    //MARK:- 去除字符串两端的空白字符
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }   
    
    //MARK:- 字符串长度
    func length() -> Int {
        return self.count
    }
    
    func indexOf(_ target: Character) -> Int? {
        return self.index(of: target)?.encodedOffset
    }
    
    func subString(to: Int) -> String {
        let endIndex = String.Index.init(encodedOffset: to)
        let subStr = self[self.startIndex..<endIndex]
        return String(subStr)
    }
    
    func subString(from: Int) -> String {
        let startIndex = String.Index.init(encodedOffset: from)
        let subStr = self[startIndex..<self.endIndex]
        return String(subStr)
    }
    
    func subString(start: Int, end: Int) -> String {
        let startIndex = String.Index.init(encodedOffset: start)
        let endIndex = String.Index.init(encodedOffset: end)
        return String(self[startIndex..<endIndex])
    }
    
    func subString(range: Range<String.Index>) -> String {
        return String(self[range.lowerBound..<range.upperBound])
    }
        
}
