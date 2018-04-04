//
//  Swift4TestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/30.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class BackReasonView: UIView {
    
    var errorsArray = [BackErrorType.houseInfo.rawValue, BackErrorType.obligee.rawValue, BackErrorType.other.rawValue]
    var lastBtnTag: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createBtns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBtns() {
        let totalCol = 3
        let gap: CGFloat = 5
        let btnW: CGFloat = (SCREEN_WIDTH - 20 - CGFloat((totalCol - 1)) * gap) / 3
        let btnH: CGFloat = 40
        for i in 0..<errorsArray.count {
            let btn = UIButton(type: .custom)
            let col = i % totalCol
            let row = i / totalCol
            btn.frame = CGRect(x: (btnW + gap) * CGFloat(col), y: (btnH + gap) * CGFloat(row), width: btnW, height: btnH)
            btn.setTitle(errorsArray[i], for: UIControlState.normal)
            btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            btn.setTitleColor(UIColor.orange, for: UIControlState.selected)
            btn.backgroundColor = UIColor.lightGray
            btn.tag = 10000 + i
            btn.addTarget(self, action: #selector(btnDidClick(btn:)), for: UIControlEvents.touchUpInside)
            addSubview(btn)
            
            lastBtnTag = 10000
        }
    }
    
    @objc func btnDidClick(btn: UIButton) {
        
        if btn.isSelected == true {
            return
        }
        
        let lastBtn = self.viewWithTag(lastBtnTag) as? UIButton
        lastBtn?.isSelected = false
        
        btn.isSelected = !btn.isSelected
        
        lastBtnTag = btn.tag
    }
}

enum BackErrorType: String {
    case houseInfo = "房产信息错误"
    case obligee = "权利人错误"
    case other = "其它"
}

class Swift4TestViewController: UIViewController {
    
    var segmentControl: UISegmentedControl!
    var textView: UITextView!
    var numLabel: UILabel!
    var contactView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        //常量 变量
        let a = 1, b = 3, c = 6
        let maxNumberOfLoginAttempts = 10
        var currentLoginAttempts = 0
        
        //类型标注【在声明一个常量或变量的时候提供类型标注，来明确变量或常量能够存储的值的类型】
        var welcomeMessage: String
        //定义多个相关的变量为相同的类型
        var red, green, blue: Double
        
        print(UInt8.min, UInt8.max)
        
        //Float 代表32位的浮点数，精度只有6位；Double 代表64位的浮点数，精度有15位；
        let f: Float = 0.4455454664646
        let g: Double = 0.353626264678868686
        print(f, g)
        
        //元组
        let httpError = (status: 404, error: "Not Found")
        print(httpError.status, httpError.error)
        
        let age = 3
        assert(age > 0, "a person age can not less than zero")
        
        let quotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin,
        please your Majesty?" he asked.
        
        "Begin at the beginning," the King said gravely, "and go on
        till you come to the end; then stop."
        """
        print(quotation)
        
        let catCharacters: [Character] = ["C", "A", "T", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        
        var welcome = "hello"
        welcome.removeSubrange(welcome.index(after: welcome.startIndex)..<welcome.endIndex)
        print(welcome)
        
        var shoppingList = ["apple"]
        shoppingList += ["orange", "banana"]
        shoppingList.remove(at: 0)
        print(shoppingList[0])
        
        for (index, value) in shoppingList.enumerated() {
            print("index: \(index), value: \(value)")
        }
        
        var air = ["name": "001"]
        air.updateValue("0001", forKey: "name")
        air["age"] = "2"
//        air["name"] = nil
        air.removeValue(forKey: "name")
        print(air)
        
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            print(tickMark)
        }
        
        let myTest1 = MyTest1(uuid: "1", title: "1.title")
        let myTest2 = MyTest1(uuid: "3", title: "2.title")
        print(myTest1 == myTest2)
        print(myTest1.title.hashValue)
        print(myTest1)
        
        let coke = Drinking.dringking(name: "Coke")
        let beer = Drinking.dringking(name: "Beer")
        print(coke.color, beer.color)
        
        let format = String(format: "%.2f", 2.3455)
        print(format)
        
        setupSegment()
        setupTextView()
        setupField()
        setupBackView()
    }
    
    func setupSegment() {
        segmentControl = UISegmentedControl(items: ["房产信息错误", "权利人错误", "其它"])
        view.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(100)
        }
        
        segmentControl.tintColor = UIColor.orange
        segmentControl.selectedSegmentIndex = 0
        
        
    }
    
    func setupTextView() {
        textView = UITextView()
        textView.backgroundColor = UIColor.lightGray
        textView.delegate = self
        view.addSubview(textView)
        
        numLabel = UILabel()
        numLabel.text = "0/100"
        numLabel.textColor = UIColor.white
        view.addSubview(numLabel)
        
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(200)
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
        }
        
        numLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(textView.snp.bottom)
            make.right.equalTo(textView.snp.right)
        }
    }
    
    func setupField() {
        
        contactView = UIView()
        contactView.backgroundColor = UIColor.lightGray
        view.addSubview(contactView)
        
        let contactLabel = UILabel()
        contactLabel.text = "联系人："
        contactView.addSubview(contactLabel)
        
        let contactField = UITextField()
        contactField.borderStyle = .roundedRect
        contactField.textAlignment = .right
        contactView.addSubview(contactField)
        
        contactView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        contactField.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(260)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(contactField.snp.left)
        }
    }
    
    func setupBackView() {
        let backV = BackReasonView()
        view.addSubview(backV)
        
        backV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.top.equalTo(contactView.snp.bottom).offset(20)
        }
    }
}

extension Swift4TestViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else { return }
        
        let index = 100 - textView.text.length()
        numLabel.text = "\(index)/100"
    }
}

class MyTest1 {
    let uuid: String
    var title: String
    init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
    
    static func ==(lhs: MyTest1, rhs: MyTest1) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension MyTest1: Equatable {

}

extension MyTest1: CustomStringConvertible {
    var description: String {
        return "MyTest1------\(self.title)"
    }
}

class Drinking {
    var color: UIColor {
        return .clear
    }
    
    class func dringking(name: String) -> Drinking {
        var drinking: Drinking
        switch name {
        case "Coke":
            drinking = Coke()
        case "Beer":
            drinking = Beer()
        default:
            drinking = Drinking()
        }
        return drinking
    }
}

class Coke: Drinking {
    override var color: UIColor {
        return .black
    }
}

class Beer: Drinking {
    override var color: UIColor {
        return .yellow
    }
}
