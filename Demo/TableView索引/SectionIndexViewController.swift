//
//  SectionIndexViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/25.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class SectionIndexViewController: UIViewController {
    
    fileprivate var tableView: UITableView!
    fileprivate var titlesArray = ["A", "B", "C", "D"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
        
        tableView.customIndexView(indexTitles: titlesArray)
    }

    func setupUI() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SectionIndexCellID")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    

}

extension SectionIndexViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionIndexCellID")
        cell?.textLabel?.text = "\(titlesArray[indexPath.section])---\(indexPath.row)"
        return cell!
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titlesArray[section]
    }

}




