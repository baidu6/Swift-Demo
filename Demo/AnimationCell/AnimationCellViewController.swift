//
//  AnimationCellViewController.swift
//  Demo
//
//  Created by 王云 on 2018/2/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class AnimationCellViewController: UIViewController {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        tableView =  UITableView(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AnimationCellID")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationAll()
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        animationTable()
//    }
    
    func animationTable() {
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    //整体做动效
    func animationAll() {
        let tableHeight = tableView.bounds.size.height
        tableView.transform = CGAffineTransform(translationX: 0, y: 80)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.tableView.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }

}

extension AnimationCellViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimationCellID")
        cell?.textLabel?.text = "AnimationCell---\(indexPath.row)"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //tableViewCell的点击动画
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("didHighlightRowAt")
        let cell = tableView.cellForRow(at: indexPath)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.commitAnimations()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        print("didUnhighlightRowAt")
        let cell = tableView.cellForRow(at: indexPath)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        cell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.commitAnimations()
    }
}
