//
//  RxSwiftTestViewController.swift
//  Demo
//
//  Created by 王云 on 2017/10/27.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftTestViewController: UIViewController {
    
    var tableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        tableView = UITableView()
        view.addSubview(tableView)
//        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let items = Observable.just((0..<20)
            .map{"\($0)"})
        items.bind(to: tableView.rx.items(cellIdentifier: "cellID", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "当前是第\(row)行"
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
    
    }

}

extension RxSwiftTestViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("didSelectRowAt\(indexPath.row)")
    }
   
}

