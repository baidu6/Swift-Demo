//
//  SwiftForwardViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/4.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class SwiftForwardViewController: UIViewController {
    
    var tableView: UITableView!
    var titles = ["01-集合", "02-StoryBoard【UItableView】", "03-申请退回", "04-字典转模型", "05-swiftyAtributes", "06-自定义密码框"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftForwardCellID")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

}

extension SwiftForwardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftForwardCellID")
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = SwiftForward01()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let storyBoard = UIStoryboard(name: "test", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SwiftForward02")
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = SwiftForward03()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = SwiftForward04()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = SwiftForward05()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = SwiftForward06()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
