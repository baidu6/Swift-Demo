//
//  TouchTableViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/29.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class TouchTableViewController: UITableViewController {
    
    var items: [String] = ["你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----", "你今天很漂亮----"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TouchCellID")
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TouchCellID", for: indexPath)
        cell.textLabel?.text = items[indexPath.row] + "\(indexPath.row + 1)"
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: cell)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row] + "\(indexPath.row + 1)"
        pushToTouchDetail(item: item)
    }
    
    func pushToTouchDetail(item: String) {
        let touchDetail = TouchDetailViewController()
        touchDetail.item = item
        self.navigationController?.pushViewController(touchDetail, animated: true)
    }

}

extension TouchTableViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let index = tableView.indexPath(for: previewingContext.sourceView as! UITableViewCell) {
            let item = self.items[index.row] + "\(index.row + 1)"
            let touchDetail = TouchDetailViewController()
            touchDetail.item = item
            return touchDetail
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)        
    }
}
