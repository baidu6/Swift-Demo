//
//  VentureAnalysisTableView.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class VentureAnalysisTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        delegate = self
        dataSource = self
        tableFooterView = UIView()
        contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: autoHeight(height: 400)))
        let gradeV = GradeView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: autoHeight(height: 230)))
        view.addSubview(gradeV)
        tableHeaderView = view
//        let circleV = CirclePercentView(frame: CGRect(x: 0, y: 0, width: autoWidth(width: 200), height: autoWidth(width: 200)))
//        tableHeaderView = circleV
        
        register(VentureAnalysisCell.self, forCellReuseIdentifier: "VentureAnalysisCellID")
    }
    
}

extension VentureAnalysisTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VentureAnalysisCellID") as! VentureAnalysisCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
