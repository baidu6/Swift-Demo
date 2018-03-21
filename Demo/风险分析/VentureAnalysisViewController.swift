//
//  VentureAnalysisViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class VentureAnalysisViewController: UIViewController {
    
    var tableView: VentureAnalysisTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        tableView = VentureAnalysisTableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
    }

}
