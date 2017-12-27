//
//  KeyBoardViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/27.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class KeyBoardViewController: UIViewController {
    
    fileprivate var priceField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupField()
    }
    
    func setupField() {
        priceField = UITextField(frame: CGRect(x: 80, y: 100, width: 200, height: 40))
        priceField.placeholder = "请输入价格"
        priceField.font = UIFont.systemFont(ofSize: 16)
        priceField.keyboardType = .decimalPad
        priceField.borderStyle = .roundedRect
        priceField.showToolBar()
        view.addSubview(priceField)
    }

}


private var TextFieldToolBarParamKey = "TextFieldToolBarParamKey"
extension UITextField {
    
    var toolBar: UIToolbar? {
        
        set(toolBar) {
            objc_setAssociatedObject(self, &TextFieldToolBarParamKey, toolBar, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &TextFieldToolBarParamKey) as? UIToolbar
        }
    }
    
    func showToolBar() {
        setupToolBar()
        self.inputAccessoryView = toolBar
    }
    
    func setupToolBar() {
        toolBar = UIToolbar()
        
        //可以让UIBarButtonItem靠右显示
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneItemDidClick))
        
        toolBar?.sizeToFit()
        toolBar?.items = [spaceItem, doneItem]
    }
    
    @objc func doneItemDidClick() {
        self.resignFirstResponder()
    }
}
