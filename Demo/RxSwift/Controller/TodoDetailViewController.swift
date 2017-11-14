//
//  TodoDetailViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/14.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TodoDetailViewController: UIViewController {
    @IBOutlet weak var finishSwitch: UISwitch!
    @IBOutlet weak var nameField: UITextField!
    var todoItem: TodoItem!
    fileprivate let todoSubject = PublishSubject<TodoItem>()
    var todo: Observable<TodoItem> {
        return todoSubject.asObservable()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        self.navigationItem.title = "ToDoDetail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
    }

    @objc func done() {
        todoItem.name = nameField.text ?? ""
        todoItem.isFinished = finishSwitch.isOn
        todoSubject.onNext(todoItem)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.becomeFirstResponder()
        if let item = todoItem {
            nameField.text = item.name
            finishSwitch.isOn = item.isFinished
        }else {
          todoItem = TodoItem()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        todoSubject.onCompleted()
    }

}
