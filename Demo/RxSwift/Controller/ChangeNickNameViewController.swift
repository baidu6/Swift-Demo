//
//  ChangeNickNameViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/10.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChangeNickNameViewController: UIViewController {
    let disposedBg = DisposeBag()

    @IBOutlet weak var nickField: UITextField!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var tapBtn: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeNickName()
        test()
        
    }
    
    //MARK:- 修改昵称
    func changeNickName() {
        let nickValid = nickField.rx.text.orEmpty.map({ (text) -> Bool in
            return text.characters.count >= 3 && text.characters.count <= 10
        })
            .share(replay: 1)
        
        nickValid.bind(to: tipsLabel.rx.isHidden)
            .disposed(by: disposedBg)
        
        nickValid.bind(to: tapBtn.rx.isEnabled)
            .disposed(by: disposedBg)
        
        tapBtn.rx.tap.subscribe { [weak self] (next) in
            self?.changeSuccess()
            }.disposed(by: disposedBg)
    }
    
    //MARK:- 修改成功
    func changeSuccess() {
        let alert = UIAlertController(title: "Alert", message: "恭喜您修改昵称成功", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- 查找数组中的元素，并显示在label上面
    func test() {
        Observable.from(["zhangsan", "lisi", "wangwu", "zhaoliu"]).filter({ value in
            return value == "lisi"
        }).map({(text) -> String in
            return "My name is \(text)"
        }).subscribe (onNext: { [weak self] text in
            self?.contentLabel.text = text
        }).disposed(by: disposedBg)
        
    }
}
