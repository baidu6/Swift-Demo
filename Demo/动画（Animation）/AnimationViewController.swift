//
//  AnimationViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class AnimationViewController: UITableViewController {
    
    private var titles = ["基础动画", "关键帧动画", "组动画", "过渡动画", "结合案例"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AniamtionCellID")
        tableView.tableFooterView = UIView()
    }

}

extension AnimationViewController {
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AniamtionCellID")
        cell?.selectionStyle = .none
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let basicVC = BasicAnimationViewController()
            basicVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(basicVC, animated: true)
        case 1:
            let vc = KeyframeAnimationViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = GroupAnimationViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = TransitionViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = CombineCaseViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
