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
    var titlesArray: [String] = ["修改昵称", "UIPickerView", "APIWrapper", "泊学"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let items = Observable.just((0..<titlesArray.count)
            .map{"\($0)"})
        items.bind(to: tableView.rx.items(cellIdentifier: "cellID", cellType: UITableViewCell.self)) { [weak self](row, element, cell) in
            cell.textLabel?.text = "当前是第\(row)行-----\(self?.titlesArray[row] ?? "")"
            print(row, element, cell)
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
        if indexPath.row == 0 { //修改密码
            let changeNick = ChangeNickNameViewController()
            self.navigationController?.pushViewController(changeNick, animated: true)
        }else if indexPath.row == 1 { //UIPickerView
            let simplePicker = SimplePickerViewController()
            self.navigationController?.pushViewController(simplePicker, animated: true)
        }else if indexPath.row == 2 {
            let wrapper = APIWrapperViewController()
            self.navigationController?.pushViewController(wrapper, animated: true)
        }else if indexPath.row == 3 {
            let step = StepByStepViewController()
            self.navigationController?.pushViewController(step, animated: true)
        }
    }
   
}

