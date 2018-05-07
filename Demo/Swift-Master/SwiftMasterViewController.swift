//
//  SwiftMasterViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SwiftMasterViewController: UIViewController {
    
    private var tableView: UITableView!
    private var datas = ["01-alertVC添加textField", "02-CAShapeLayer+UIBezierPath", "03-多线程", "04-动画"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MasterCellID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
}

extension SwiftMasterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCellID")
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = AlertTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = PathTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = QueueTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = AnimationTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
         
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autoHeight(height: 100)
    }
}
