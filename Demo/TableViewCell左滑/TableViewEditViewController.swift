//
//  TableViewEditViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwipeCellKit

class TableViewEditViewController: UIViewController {
    
    fileprivate var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: view.bounds)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EditCellID")
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "EditCellID")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
}


extension TableViewEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCellID") as! SwipeTableViewCell
        cell.textLabel?.text = "Nice Day \(indexPath.row)"
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK:- SwipeTableViewCellDelegate

extension TableViewEditViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let action1 = SwipeAction(style: .default, title: "Delete") { (_, _) in
            print("Delete")
        }
        action1.transitionDelegate = ScaleTransition.default
        action1.textColor = UIColor.red
        action1.backgroundColor = UIColor.orange
        return [action1]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .selection
        options.transitionStyle = .reveal
        return options
    }
}

extension TableViewEditViewController {
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //
    //        let more = UITableViewRowAction(style: .normal, title: "更多") { (_, _) in
    //            print("点击了更多")
    //        }
    //        more.backgroundColor = UIColor.lightGray
    //
    //        let favorite = UITableViewRowAction(style: .normal, title: "旗标", handler: { (_, _) in
    //            print("点击了旗标")
    //        })
    //        favorite.backgroundColor = UIColor.orange
    //
    //        let delete = UITableViewRowAction(style: .normal, title: "删除") { (_, _) in
    //            print("点击了删除")
    //        }
    //        delete.backgroundColor = UIColor.red
    //
    //        return [delete, favorite, more]
    //    }
}

extension TableViewEditViewController {
    //MARK:- IOS11
    //    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let unRead = UIContextualAction(style: .normal, title: "未读") { (_, _, handler) in
    //            print("d点击了未读")
    //            handler(true)
    //        }
    //        unRead.backgroundColor = UIColor.red
    //
    //        return UISwipeActionsConfiguration(actions: [unRead])
    //    }
    //
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let delete = UIContextualAction(style: .normal, title: "删除") { (_, _, handler) in
    //            print("点击了delete")
    //            handler(true)
    //        }
    //        delete.backgroundColor = UIColor.red
    //
    //        let like = UIContextualAction(style: .normal, title: "喜欢") { (_, _, handler) in
    //            print("点击了喜欢")
    //            handler(true)
    //
    //        }
    //        like.backgroundColor = UIColor.green
    //
    //        let collect = UIContextualAction(style: .normal, title: "收藏") { (_, _, handler) in
    //            print("收藏")
    //            handler(true)
    //
    //        }
    //        collect.backgroundColor = UIColor.orange
    //
    //        return UISwipeActionsConfiguration(actions: [delete, like, collect])
    //    }
}
