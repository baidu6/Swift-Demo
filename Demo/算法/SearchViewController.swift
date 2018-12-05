//
//  LineSearchViewController.swift
//  Demo
//
//  Created by 王云 on 2018/7/2.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    fileprivate var titlesArray = ["线性结构查找算法", "排序方法"]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "算法"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellID")
        tableView.tableFooterView = UIView()
    }
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellID")
        cell?.textLabel?.text = titlesArray[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = LineSerachViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = SortedViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
