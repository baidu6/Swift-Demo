//
//  EstimateCell.swift
//  Demo
//
//  Created by 王云 on 2017/12/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwiftForms

typealias SimpleCallBack = () -> Void

open class EstimateCell: FormTextFieldCell {
    
    var textFieldDidBegin: SimpleCallBack?
  
    open override func configure() {
        super.configure()
        textField.delegate = self
    }

}

extension EstimateCell: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidBegin?()
    }
}
