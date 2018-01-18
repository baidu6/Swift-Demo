//
//  JSViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/17.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class JSViewController: UITableViewController {
    
    fileprivate var titlesArray = ["UIWebView", "WKWebView"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "JSCellID")
        
    }

}

extension JSViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JSCellID")
        cell?.textLabel?.text = titlesArray[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(UIWebViewController(), animated: true)
        }else if indexPath.row == 1 {
            self.navigationController?.pushViewController(WKWebViewController(), animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
