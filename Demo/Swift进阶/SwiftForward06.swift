//
//  SwiftForward06.swift
//  Demo
//
//  Created by 王云 on 2018/4/10.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

typealias Filter = (CIImage) -> CIImage

class SwiftForward06: UIViewController {
    
    private var password: CustomPassword!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "自定义密码框"
        view.backgroundColor = UIColor.white
        
        password = CustomPassword()
        view.addSubview(password)
        
        password.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        print(incrementArray(xs: [1, 2, 3], transform: {$0 * 2}))
        print(incrementArray(xs: [1, 2, 3], transform: {$0 % 2 == 0}))
        print(incrementArray(xs: [1, 2, 3], transform: {$0 * 2}))
        
        print(getSwiftFiles(files: ["Ahgoagh", "gahgoa", "haogh"]))
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(password.value)
    }
    
    func incrementArray(xs: [Int], transform: (Int) -> (Int)) -> [Int] {
        var result: [Int] = []
        for i in xs {
            result.append(transform(i))
        }
        return result
    }
    
    func incrementArray(xs: [Int], transform: (Int) -> Bool) -> [Bool] {
        var result: [Bool] = []
        for i in xs {
            result.append(transform(i))
        }
        return result
    }
    
    func incrementArray<T>(xs: [Int], transform: (Int) -> T) -> [T] {
        var result: [T] = []
        for i in xs {
            result.append(transform(i))
        }
        return result
    }
    
    func map<Element, T>(xs: [Element], transform: (Element) -> T) -> [T] {
        var result: [T] = []
        for i in xs {
            result.append(transform(i))
        }
        return result
    }
    
    func getSwiftFiles(files: [String]) -> [String] {
        var result: [String] = []
        for file in files {
            if file.hasPrefix("A") {
                result.append(file)
            }
        }
        return result
    }
}

class CustomPassword: UIView {
    
    let DotCount = 6
    let DotSize = CGSize(width: 10, height: 10)
    let FieldWidth = SCREEN_WIDTH - autoWidth(width: 120)
    let FieldHeight = autoHeight(height: 100)
    
    var value: String? {
        get {
            return textField.text
        }
    }
    
    private var dotArray = [UIView]()
    private var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        let itemW = FieldWidth / CGFloat(DotCount)
        
        textField = UITextField(frame: CGRect(x: autoWidth(width: 60), y: 0, width: FieldWidth, height: FieldHeight))
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .editingChanged)
        addSubview(textField)
        
        //分割线
        for i in 0..<(DotCount - 1) {
            let line = UIView(frame: CGRect(x: textField.frame.minX + itemW * CGFloat((i + 1)), y: 0, width: 1, height: FieldHeight))
            line.backgroundColor = UIColor.gray
            addSubview(line)
        }
        
        //点
        for i in 0..<DotCount {
            let dotView = UIView(frame: CGRect(x: textField.frame.minX + CGFloat(i) * itemW + (itemW - DotSize.width) * 0.5, y: (FieldHeight - DotSize.height) * 0.5, width: DotSize.width, height: DotSize.height))
            dotView.backgroundColor = UIColor.black
            dotView.layer.cornerRadius = DotSize.width * 0.5
            dotView.layer.masksToBounds = true
            dotView.isHidden = true
            addSubview(dotView)
            dotArray.append(dotView)
        }
        
        self.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(FieldHeight)
        }
    }
    
    func clearPassword() {
        textField.text = ""
        textFieldDidChanged(textField: textField)
    }
}

extension CustomPassword: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        } else if string.count == 0 {   //删除键
            return true
        } else if (textField.text?.count)! >= DotCount {
            return false
        }else {
            return true
        }
    }

    @objc func textFieldDidChanged(textField: UITextField) {
        guard let count = textField.text?.count else {
            return
        }
        for dotView in dotArray {
            dotView.isHidden = true
        }
        for i in 0..<count {
            dotArray[i].isHidden = false
        }
    }
}
