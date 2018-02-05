//
//  CustomSheetViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/30.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CustomSheetViewController: CustomPresentBottomInController {
    
    var actionTitle: String?
    var array: [String] = ["A", "B", "C"]
    let rowHeight: CGFloat = 50
    
    var container: UIView!
    var tableView: UITableView!
    var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    //MARK:- 初始化UI
    func setupUI() {
        view.backgroundColor = UIColor.clear
        container = UIView(frame: UIScreen.main.bounds)
        container.backgroundColor = UIColor.orange
        view.addSubview(container)
        
        tableView = UITableView(frame: container.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SheetCellID")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        container.addSubview(tableView)
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        headerView.backgroundColor = UIColor.lightGray
        container.addSubview(headerView)
        tableView.tableHeaderView = headerView
        
        let label = UILabel(frame: headerView.bounds)
        label.text = title
        label.textAlignment = .center
        label.textColor = UIColor.black
        print(label.layer.anchorPoint)
        label.font = UIFont.systemFont(ofSize: 14)
        headerView.addSubview(label)
        
        var height = CGFloat(self.array.count) * rowHeight
        height += headerView.height
        if container.height > height {
            var frame = container.frame
            frame.size.height = height
            container.frame = frame
            container.anchorPoint = CGPoint(x: 0, y: 1)
            container.center = CGPoint(x: 0, y: self.view.frame.size.height)
            tableView.bounces = false
        }
        
        tableView.reloadData()
    }
    
    func setArray(array: [String]) {
        self.array = array
    }
 
}

extension CustomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SheetCellID")
        cell?.textLabel?.text = array[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
