//
//  MaterialTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/26.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit


class MaterialTestViewController: UIViewController {
    
    private var tableView: UITableView!
    private var titlesArray = ["01-Color", "02-TextField", "03-Button", "04-Switch", "05-Card", "06-FABMenu", "07-ToolBar", "08-SearchBar"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MaterialTestCellID")
        view.addSubview(tableView)
    }

}

extension MaterialTestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialTestCellID")
        cell?.textLabel?.text = titlesArray[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = MaterialColorTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = MaterialTextFieldViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = MaterialButtonTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = MaterialSwitchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = MaterialCardViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = MaterialFABMenuViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let vc = MaterialToolBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            let vc = MaterialSearchBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
