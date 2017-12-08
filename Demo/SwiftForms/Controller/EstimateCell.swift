//
//  EstimateCell.swift
//  Demo
//
//  Created by 王云 on 2017/12/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwiftForms


enum Type: Int{
    case BuildNumber
    case UnitNumber
    case RoomNumber
}

typealias SimpleCallBack = () -> Void

open class EstimateCell: FormTextFieldCell {
    
    var fieldDidBegin: SimpleCallBack?

    open override func configure() {
        super.configure()
        
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.delegate = self

    }

}

extension EstimateCell: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.fieldDidBegin?()
    }
}
