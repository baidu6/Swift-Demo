//
//  ViewController.swift
//  Demo
//
//  Created by 王云 on 2017/10/27.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

import SnapKit

typealias  DictionaryDefault = Dictionary<String, Any>



class ViewController: UIViewController {
    
    var tableView: BaseTableView!
    var namesArray = ["CoreData", "Realm", "RxSwift", "SwiftForms", "AnimationNumbers", "引用类型和值类型","GCDTest", "Set(集合)Test", "函数闭包练习", "3DTouch(UITableView)", "UI预加载动画", "自定义TableView索引", "KeyBoard", "Gradient(渐变)", "TableView左边滑动", "动画", "JS交互", "下拉菜单", "加载gif动画", "Presented", "给Cell添加动画", "CustomStringConvertible协议"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        self.navigationItem.title = "Demo"
        
        setupTableView()
        
//        let testString = "HELLO"
//        let range = Range(NSRange(location: 0, length: 2), in: testString)
//        print(testString.subString(range: range!))
        test()
        
    }

    func setupTableView() {
        tableView = BaseTableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 49 - 64))
        tableView.estimatedRowHeight = ScreenHeight
//        tableView.register(UITableViewCellText.self, forCellReuseIdentifier: "DemoCellID")
        tableView.register(UITableViewCellDetail.self, forCellReuseIdentifier: "DemoCellID")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
//        if #available(iOS 11.0, *) {
//
//            tableView.snp.makeConstraints({ (make) in
//                make.edges.equalTo(view.safeAreaLayoutGuide)
//            })
//        }else {
//            tableView.snp.makeConstraints({ (make) in
//                make.edges.equalTo(view)
//            })
//        }
        
        let footerView = UIView(frame: CGRect(x: (view.frame.size.width - 200) * 0.5, y: 30, width: ScreenWidth, height: 70))
        let path = UIBezierPath(roundedRect: footerView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 5, height: 5))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        footerView.layer.mask = layer
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.orange
        button.frame = CGRect(x: 0, y: 20, width: 200, height: 40)
        button.setTitle("Present", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        footerView.addSubview(button)
        tableView.tableFooterView = footerView
        
    }
    
    @objc func buttonClick() {
        let sheetVC = CustomSheetViewController()
        sheetVC.title = "请选择"
        self.present(sheetVC, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCellID") as! UITableViewCellDetail
        cell.displayData(dict: ["title": namesArray[indexPath.row], "detail": "点击查看详情----"])
//        cell.displayData(title: namesArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let coreDataVC = CoreDataTestViewController()
            self.navigationController?.pushViewController(coreDataVC, animated: true)
        }else if indexPath.row == 1 {
            let realmVC = RealmTestViewController()
            self.navigationController?.pushViewController(realmVC, animated: true)
        }else if indexPath.row == 2 {
            let rxswiftVC = RxSwiftTestViewController()
            self.navigationController?.pushViewController(rxswiftVC, animated: true)
        }else if indexPath.row == 3 {
            let forms = SwiftFormTestViewController()
            self.navigationController?.pushViewController(forms, animated: true)
        }else if indexPath.row == 4 {
            let animationNum = AnimationNumbersViewController()
            self.navigationController?.pushViewController(animationNum, animated: true)
        }else if indexPath.row == 5 {
            let vc = ClassStructViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            let test = GCDTestViewController()
            self.navigationController?.pushViewController(test, animated: true)
        }else if indexPath.row == 7 {
            let setVC = SetTestViewController()
            self.navigationController?.pushViewController(setVC, animated: true)
        }else if indexPath.row == 8 {
            let funcVC = FunTestViewController()
            self.navigationController?.pushViewController(funcVC, animated: true)
        }else if indexPath.row == 9 {
            let touchVC = TouchTableViewController()
            self.navigationController?.pushViewController(touchVC, animated: true)
        }else if indexPath.row == 10 {
            let vc = PreviewLoadingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 11 {
            let vc = SectionIndexViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 12 {
            let vc = KeyBoardViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 13 {
            let vc = GradientViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 14 {
            let vc = TableViewEditViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 15 {
            let vc = AnimationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 16 {
            let vc = JSViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 17 {
            let vc = CustomAlertViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 18 {
            let vc = GifTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 19 {
            let vc = PresentTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 20 {
            let vc = AnimationCellViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 21 {
            let vc = CustomStringConvertibleController()
            print(vc)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

class BaseTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.white
    }
    
    //MARK:- 隐藏分割线
    func hiddenSeparator() {
        separatorInset = UIEdgeInsetsMake(0, ScreenWidth, 0, 0)
    }
    
    //MARK:- 去除左边分割线的间距
    func zeroSeparator() {
        separatorInset = UIEdgeInsets.zero
    }
    
    //MARK:- 隐藏分割线后自己添加分割线
    func addSeparatorZero() {
        hiddenSeparator()
        addLineBottom(edgeInsets: UIEdgeInsets.zero)
    }
    
    //MARK:- 隐藏分割线后自己添加（默认有15的左边间距）
    func addSeparatorDefault() {
        hiddenSeparator()
        addLineBottom(edgeInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
    }
    
    func displayData(index: IndexPath, data: DictionaryDefault?) {
        self.indexPath = index
    }
    
}

class UITableViewCellText: BaseTableViewCell {
    fileprivate var titleLabel: UILabel!
    override func setupUI() {
        super.setupUI()
        
        addSeparatorZero()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func displayData(title: String?) {
        titleLabel.text = title
    }
}

class UITableViewCellDetail: BaseTableViewCell {
    
    fileprivate var titleLabel: UILabel!
    fileprivate var descLabel: UILabel!
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        
        descLabel = UILabel()
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.lightGray
        contentView.addSubview(descLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    //MARK:- 展示数据
    func displayData(dict: [String: Any]) {
        titleLabel.text = dict["title"] as? String
        descLabel.text = dict["detail"] as? String
     }
}

extension UIView {
    
    @discardableResult
    func addLineBottom(edgeInsets: UIEdgeInsets) -> UIView {
        return addLine(edgeInsets: edgeInsets)
    }
    
    func addLine(color: UIColor = UIColor.lightGray, height: CGFloat = 0.5, edgeInsets: UIEdgeInsets? = nil) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-(edgeInsets?.bottom ?? 0))
            make.left.equalToSuperview().offset(edgeInsets?.left ?? 0)
            make.right.equalToSuperview().offset(-(edgeInsets?.right ?? 0))
            make.height.equalTo(height)
        }
        return view
    }
}

struct Vector2D {
    var x = 0
    var y = 0
    
    static func +(left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}
extension ViewController {
    func doWork(block: @escaping () -> ()) {
        print("doWork")
        DispatchQueue.main.async {
            block()
        }
    }
    
    func test() {
        doWork {
            print("work")
        }
        
        let v1 = Vector2D(x: 1, y: 2)
        let v2 = Vector2D(x: 3, y: 4)
        let v3 = v1 + v2
        print(v3)
        
        let p: P = "fdfd"
        p.name = "zhagnsan"
        
        var array = [1, 2, 3, 4, 5, 6]
        print(array[[0, 2, 4]])
        array[[0, 2, 4]] = [11, 33, 55]
        print(array)
        
        let mixed = [IntOrString.IntValue(10), IntOrString.StringValue("A")]
        for value in mixed {
            switch value {
            case let .IntValue(i):
                print(i * 2)
            case let .StringValue(s):
                print(s)
            case .noneType:
                print("none")
            }
        }
        
        let name = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        name.forEach {
            switch $0 {
            case let x where x.hasPrefix("z"):
                print("ZZZ")
            default:
                print("HEHE")
            }
        }
        
        let num: [Int?] = [99, 88, nil]
        let n = num.flatMap {$0}
        for score in n where score > 60 {
            print("及格")
        }

        
        let obj = Class()
        let nameresult = name.lastWith(where: {$0.hasPrefix("z")})
        print(nameresult)
        
        doworkAsync {
            print("222")
        }
    }
    
    func doworkAsync(block: @escaping ()->()){
        print("111")

        UIView.animate(withDuration: 2, animations: {
            
        }) { (_) in
            block()
        }
    
        print("333")
    }
}

extension Sequence where Element: Hashable {
    func lastWith(where predicate: (Element) -> Bool) -> Element? {
        for element in self.reversed() where predicate(element) {
            return element
        }
        return nil
    }
    
    func unique() -> [Element] {
        var result: Set<Element> = []
        return filter({ element in
            if result.contains(element) {
                return false
            }else {
                result.insert(element)
                return true
            }
        })
    }
}

class MyyClass: NSObject {
    @objc dynamic var date = Date()
}
private var myContext = 0
class Class: NSObject {
    var myObject: MyyClass!
    var observation: NSKeyValueObservation!
    
    override init() {
        super.init()
        myObject = MyyClass()
        print("初始化myClass，当前日期是\(myObject.date)")
//        myObject.addObserver(self, forKeyPath: "date", options: .new, context: &myContext)
        
        observation = myObject.observe(\MyyClass.date, options: [.new]) { (_, change) in
            if let newDate = change.newValue {
                print("发生变化\(newDate)")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.myObject.date = Date()
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let change = change, context == &myContext {
            if let newDate = change[.newKey] as? Date {
                print("MyyClass 日期发生变化\(newDate)")
            }
        }
    }
}


enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
    case noneType
}

class P: ExpressibleByStringLiteral {
    var name: String {
        willSet {
            print(newValue)
        }
        
        didSet {
           print(oldValue)
        }
    }
    init(name value: String) {
        self.name = value
    }
    required convenience init(stringLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(name: value)
    }
}

//MARK:- 取出数组中指定位置的值或者给数组中指定位置赋值
extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                result.append(self[i])
            }
            return result
        }
        
        set {
            for(index, i) in input.enumerated() {
                self[i] = newValue[index]
            }
        }
    }
}

class Cat {
    var name: String
    init() {
        name = "Cat"
    }
}

class Tiger: Cat {
    let age: Int
    override init() {
        age = 10
        super.init()
    }
}

protocol A1 {
    func method1() -> String
}

extension A1 {
    func method1() -> String {
        return ""
    }
    func method2() -> Int {
        return 1
    }
}

struct B1: A1 {
    func method1() -> String {
        return "H"
    }
}



