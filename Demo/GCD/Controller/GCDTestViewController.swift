//
//  GCDTestViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/9.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class GCDTestViewController: UIViewController {
    
    var tapBtn: UIButton!
    
    let opertionQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupTapBtn()

//        //1.串行
//        let queue1 = DispatchQueue(label: "queue1")
//        queue1.sync {
//            for i in 0..<10 {
//                print("同步\(i)")
//            }
//        }
//
//        queue1.async {
//            for i in 0..<10 {
//                print("异步\(i)")
//            }
//        }
        
        //2.并行
        let queue2 = DispatchQueue(label: "queue2", qos: DispatchQoS.default, attributes: .concurrent)
        
//        queue2.async {
//            for i in 0..<10 {
//                print("i\(i)")
//            }
//        }
//
//        queue2.async {
//            for j in 0..<10 {
//                print("j\(j)")
//            }
//        }

        //3.同步

        //4.异步
        
//        semaphore()
//        groupTest()
        
        operationQueue()
    }
    
    func setupTapBtn() {
        tapBtn = UIButton(type: .custom)
        tapBtn.setTitle("Tap Me", for: UIControlState.normal)
        tapBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        tapBtn.addTarget(self, action: #selector(tap), for: UIControlEvents.touchUpInside)
        tapBtn.backgroundColor = UIColor.lightGray
        view.addSubview(tapBtn)
        tapBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    @objc func tap() {
        let alert = UIAlertController(title: "Alert", message: "为了验证异步不阻塞主线程", preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func semaphore() {
        let queue = DispatchQueue.global()
        let semaphore = DispatchSemaphore(value: 0)
//        for i in 0..<10 {
//            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
//            queue.async {
//                print(i)
//                semaphore.signal()
//            }
//        }
//
        queue.async {
            for i in 0..<10 {
                print("i:\(i)")
            }
        }
        
        queue.async {
            for j in 0..<20 {
                print("j\(j)")
            }
            semaphore.signal()
        }
        
        queue.async {
            for k in 0..<30 {
                _ = semaphore.wait(timeout: DispatchTime.distantFuture)
                print("k\(k)")
                semaphore.signal()
            }
        }
        
    }
    
    func groupTest() {
        let queue2 = DispatchQueue(label: "queue2", qos: DispatchQoS.default, attributes: .concurrent)
        let group = DispatchGroup()
        
        group.enter()
        queue2.async {
            for i in 0..<10 {
                print("i:\(i)")
            }
        }
        group.leave()
        
        
        group.enter()
        queue2.async {
            for j in 0..<1000 {
                print("j\(j)")
            }
        }
        group.leave()
        
        
        group.enter()
        for k in 0..<10000 {
            print("k:\(k)")
        }
        group.leave()
        
        group.notify(queue: queue2) {
            print("异步全部完成，赞赞赞赞赞")
        }
    }
    
    func operationQueue() {
        
        let blockOperation1 = BlockOperation {
            for i in 0..<20000000000 {
                print("i:\(i)")
            }
            print("blockOperation1")
        }
        
        let blockOperation2 = BlockOperation {
            for j in 0..<20000000000 {
                print("j\(j)")
            }
            print("blockOperation2")
        }
        
        let blockOperation3 = BlockOperation {
            for k in 0..<20000000000 {
                print("k:\(k)")
            }
            print("blockOperation3")
        }
        
//        //设置依赖关系
//        blockOperation2.addDependency(blockOperation1)
        
        //设置最大并发数量
        opertionQueue.maxConcurrentOperationCount = 2
        
        opertionQueue.addOperation(blockOperation1)
        opertionQueue.addOperation(blockOperation2)
        opertionQueue.addOperation(blockOperation3)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        //取消
//        opertionQueue.cancelAllOperations()
        
//        //暂停一个queue不会导致正在执行的operation在任务中途暂停,只是简单地阻止调度新Operation执行
//        opertionQueue.isSuspended = true
        
    }

}

//如果协议中包含@optional方法，必须用@objc修饰
@objc protocol CurrentDataSource {
   @objc optional func numberOfRows(rows inView: Int)
   @objc optional func numberOfCols(cols inView: Int)
}

enum ClassType: Int {
    case TableViewType
    case ScrollViewType
    case PickerViewType
}

class MyClass {
    var name: String?
    var age: Int?
    func getName() -> String? {
        return name
    }
}

extension MyClass {
    var height: Double? {
        if let age = age {
            return Double(age * 100)
        }
        return 100
    }
}
