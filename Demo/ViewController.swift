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
    var namesArray = ["CoreData", "Realm", "RxSwift", "SwiftForms", "AnimationNumbers", "引用类型和值类型","GCDTest", "Set(集合)Test", "函数闭包练习", "3DTouch(UITableView)", "UI预加载动画", "自定义TableView索引", "KeyBoard"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Demo"
        
        setupTableView()
    }

    func setupTableView() {
        tableView = BaseTableView()
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
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let footerView = UIView(frame: CGRect(x: (view.frame.size.width - 200) * 0.5, y: 30, width: 200, height: 50))
        let path = UIBezierPath(roundedRect: footerView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 5, height: 5))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        footerView.layer.mask = layer
        footerView.backgroundColor = UIColor.red
        tableView.tableFooterView = footerView
        
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
            coreDataVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(coreDataVC, animated: true)
        }else if indexPath.row == 1 {
            let realmVC = RealmTestViewController()
            realmVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(realmVC, animated: true)
        }else if indexPath.row == 2 {
            let rxswiftVC = RxSwiftTestViewController()
            rxswiftVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(rxswiftVC, animated: true)
        }else if indexPath.row == 3 {
            let forms = SwiftFormTestViewController()
            forms.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(forms, animated: true)
        }else if indexPath.row == 4 {
            let animationNum = AnimationNumbersViewController()
            animationNum.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(animationNum, animated: true)
        }else if indexPath.row == 5 {
            let vc = ClassStructViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            let test = GCDTestViewController()
            test.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(test, animated: true)
        }else if indexPath.row == 7 {
            let setVC = SetTestViewController()
            setVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(setVC, animated: true)
        }else if indexPath.row == 8 {
            let funcVC = FunTestViewController()
            funcVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(funcVC, animated: true)
        }else if indexPath.row == 9 {
            let touchVC = TouchTableViewController()
            touchVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(touchVC, animated: true)
        }else if indexPath.row == 10 {
            let vc = PreviewLoadingViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 11 {
            let vc = SectionIndexViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 12 {
            let vc = KeyBoardViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

