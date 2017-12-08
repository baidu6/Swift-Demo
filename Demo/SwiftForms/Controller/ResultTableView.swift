//
//  ResultTableView.swift
//  Demo
//
//  Created by 王云 on 2017/12/8.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class ResultTableView: UITableView {
    
    var datas: [String] = [String]() {
        didSet {
            reloadData()
        }
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        tableFooterView = UIView()
        register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResultTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell")
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    
    
}
