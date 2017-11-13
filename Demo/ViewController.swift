//
//  ViewController.swift
//  Demo
//
//  Created by 王云 on 2017/10/27.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView: BaseTableView!
    var namesArray = ["CoreData", "Realm", "RxSwift", "SwiftForms", "AnimationNumbers", "引用类型和值类型","GCDTest", "Set(集合)Test", "函数闭包练习"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Demo"
        
        setupTableView()
    }

    func setupTableView() {
        tableView = BaseTableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DemoCellID")
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
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        //IOS11新特性
        print(view.safeAreaInsets)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCellID")
        cell?.textLabel?.text = namesArray[indexPath.row]
        return cell!
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
        }
    }
}

