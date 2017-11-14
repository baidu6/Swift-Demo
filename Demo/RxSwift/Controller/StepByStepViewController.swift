//
//  StepByStepViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/14.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StepByStepViewController: UIViewController {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! + "/items.data"

    @IBOutlet weak var tableView: UITableView!
    
    var todoItems = Variable<[TodoItem]>([])
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        self.navigationItem.title = "ToDo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addItem))
        print("\n\n\n")
        loadTodoItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
//        test1()
//        test2()
//        test3()
//        test4()
        test5()
        
    }
    
    func loadTodoItems() {
        print("filePath\(path)")
        if let value = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [TodoItem]{
            todoItems.value = value
            self.tableView.reloadData()
        }
    }
    
    @objc func addItem() {
        let todoDetail = TodoDetailViewController()
        todoDetail.todo.subscribe(onNext: {[weak self] newTodo in
            self?.todoItems.value.append(newTodo)
            self?.tableView.reloadData()
            }, onDisposed: {
                print("add a new todoItem")
        }).disposed(by: bag)
        
        self.navigationController?.pushViewController(todoDetail, animated: true)
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        todoItems.value.removeAll()
        tableView.reloadData()
    }
    
    
    @IBAction func saveItem(_ sender: Any) {
        
        NSKeyedArchiver.archiveRootObject(todoItems.value, toFile: path)
       
    }
    
    
    func test1() {
        //取出所有偶数
        let stringArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let result = stringArray.flatMap{ Int($0) }.filter{$0 % 2 == 0}
        print("\nstepByStep\(result)")
        
        
        _ = Observable.of("1", "2", "3", "4", "5", "6")
            .map{ Int($0) }
            .filter{
                if let item = $0, item % 2 == 0 {
                    return true
                }
                return false
            }
            .skip(1)
            .subscribe{ event in
                print(event)
            }
    }
    
    //MARK:- 创建Observable
    func test2() {
       let customOb = Observable<Int>.create{ observer in
            observer.onNext(10)
            observer.onNext(11)
            
            //complete
            observer.onCompleted()
            return Disposables.create()
        }
        
        
        let disposeBag = DisposeBag()
        customOb.subscribe(onNext: {print($0)},
                           onError: {print($0)},
                           onCompleted: {print("On Completed")},
                           onDisposed: {print("On Disposed")}
                           )
            .disposed(by: disposeBag)
        
    }
    
    //MARK:- Subject用法
    func test3() {
        
    }

    //MARK:- 忽略特定事件
    func test4() {
        let tasks = PublishSubject<String>()
        //正常订阅
//        tasks.subscribe{print($0)}
//            .disposed(by: bag)
        
        //忽略事件，只接受.completed事件
//        tasks.ignoreElements().subscribe{print($0)}
//            .disposed(by: bag)
        
        //忽略指定个数的事件
//        tasks.skip(2).subscribe{ print($0)}
//            .disposed(by: bag)
        
        //skipWhile，遇到不满足条件之后，就不忽略了
//        tasks.skipWhile{$0 == "Task1"}
//            .subscribe{print($0)}
//            .disposed(by: bag)
        
        //skipUntil
//        let temper = PublishSubject<Int>()
//        tasks.skipUntil(temper)
//            .subscribe{print($0)}
//            .disposed(by: bag)
        
        //distinctUntilChanged 忽略事件中连续重复的
        /**
         next(Task1)
         next(Task3)
         next(Task5)
         next(Task3)
         completed
         */
//        tasks.distinctUntilChanged().subscribe{print($0)}
//            .disposed(by: bag)
        
        tasks.take(2).subscribe{
            print($0)
        }.disposed(by: bag)
        
        tasks.onNext("Task1")
        tasks.onNext("Task1")
        tasks.onNext("Task3")
        tasks.onNext("Task5")
        tasks.onNext("Task3")
        tasks.onCompleted()
        
    }

    //MARK:- 了解常用的transform operators
    func test5() {
        //toArray
//        Observable.of(1, 2, 3)
//            .toArray()
//            .subscribe{
//                print(type(of: $0))
//                print($0)
//            }
//            .disposed(by: bag)
        
        let a = Player(score: Variable(90))
        let b = Player(score: Variable(50))
        let players = PublishSubject<Player>()
        players.asObservable()
            .flatMapLatest{
                $0.score.asObservable()
            }
            .subscribe{
                print($0)
            }
            .disposed(by: bag)
        
        players.onNext(a)
        a.score.value = 55
        players.onNext(a)
        a.score.value = 99
        
        
    }
}

struct Player {
    var score: Variable<Int>
}

extension StepByStepViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        let item = todoItems.value[indexPath.row]
        cell?.textLabel?.text = item.name
        cell?.textLabel?.textColor = item.isFinished ? UIColor.red : UIColor.black
        print("item isfinished \(item.isFinished)")
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let todoDetail = TodoDetailViewController()
        todoDetail.todoItem = todoItems.value[indexPath.row]
        todoDetail.todo.subscribe(onNext: { [weak self] newTodoItem in
            self?.todoItems.value[indexPath.row] = newTodoItem
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }, onDisposed: {
                print("Item is changed")
        }).disposed(by: bag)
        
        self.navigationController?.pushViewController(todoDetail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        todoItems.value.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

class TodoItem: NSObject, NSCoding {
    var name: String = ""
    var isFinished: Bool = false
    
    override init() {
        super.init()
    }
    
    convenience init(name: String, isFinished: Bool) {
        self.init()
        self.name = name
        self.isFinished = isFinished
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        }
        if let isFinished = aDecoder.decodeObject(forKey: "isFinished") as? String {
            if let finished = Int(isFinished) {
                self.isFinished = finished == 0 ? false : true
            }
        }
   
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode("\(isFinished == true ? 1 : 0)", forKey: "isFinished")
    }
 
}
