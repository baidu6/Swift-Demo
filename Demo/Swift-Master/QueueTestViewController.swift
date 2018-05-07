//
//  QueueTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/27.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class QueueTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "多线程"
        view.backgroundColor = UIColor.white
        
//        simpleTest1()
//        simpleTest2()
//        simpleTest3()
//        simpleTest4()
//        simpleTest5()
//        simpleTest6()
//        simpleTest7()
//        simpleTest8()
        simpleTest9()
    }
    
    //串行同步【串行队列和主队列都是串行输出的，也就是说线程也是一个串行队列】
    func simpleTest1() {
        
        let queue = DispatchQueue(label: "queue1")
        queue.sync {
            for i in 0..<10 {
                print("串行-同步队列执行:\(i)")
            }
        }
        
        for j in 0..<10 {
            print("同步主队列执行: \(j)")
        }
    }
    
    //串行异步【异步队列不会阻塞当前线程 而是会开另外一个线程来执行当前的任务，而主线程上的任务也就不会被阻塞，所以二者是同步输出的】
    func simpleTest2() {
        let queue = DispatchQueue(label: "queue1")
         queue.async {
            for i in 0..<10 {
                print("串行-异步队列执行:\(i)")
            }
        }
        
        for j in 0..<10 {
            print("同步主队列执行: \(j)")
        }
    }
    
    //串行队列是一个一个执行；并发队列是分线程并行执行
    func simpleTest3() {
        
        //串行队列
        let queue1 = DispatchQueue(label: "simpleTest3", qos: DispatchQoS.unspecified)
        queue1.async {
            for i in 0..<10 {
                print("😝: \(i)")
            }
        }
        queue1.async {
            for i in 20..<30 {
                print("😂: \(i)")
            }
        }
        
        /**
         
        //并发队列
        let queue = DispatchQueue(label: "simpleTest3", qos: DispatchQoS.unspecified, attributes: .concurrent)
        queue.async {
            for i in 0..<10 {
                print("😝: \(i)")
            }
        }
        queue.async {
            for i in 20..<30 {
                print("😂: \(i)")
            }
        }
         
        */
    }
    
    //异步线程 同步任务
    func simpleTest4() {
        let queue = DispatchQueue(label: "queueTest4", qos: DispatchQoS.unspecified, attributes: DispatchQueue.Attributes.concurrent)
        
        queue.sync {
            for i in 0..<10 {
                print("🐶：\(i)")
            }
        }
        queue.sync {
            for i in 20..<30 {
                print("猫：\(i)")
            }
        }
        
    }
    
    //group【监听一组任务是否完成】
    func simpleTest5() {
        let group = DispatchGroup()
        
        let queue = DispatchQueue(label: "simpleTest5", qos: DispatchQoS.unspecified, attributes: DispatchQueue.Attributes.concurrent)
        
        queue.async(group: group) {
            for i in 0..<10 {
                print("🐱group: \(i)")
            }
        }
        
        queue.async(group: group) {
            for j in 20..<30 {
                print("🐶group: \(j)")
            }
        }

        group.notify(queue: queue) {
            print("🐱🐶 打印完毕。")
        }
        
    }
    
    func simpleTest6() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            for i in 0..<10 {
                print("🐱：\(i)")
            }
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            for j in 20..<30 {
                print("🐶：\(j)")
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.global()) {
            print("all have done!")
        }
    }
    
    func simpleTest7() {
        //['seməfɔː]
        let semaphore = DispatchSemaphore(value: 2)
        
        let queue1 = DispatchQueue(label: "queue1", qos: .unspecified, attributes: .concurrent)
        queue1.async {
            semaphore.wait()
            for i in 0..<30 {
                print("🐱：\(i)")
            }
            semaphore.signal()
        }
        
        
        let queue2 = DispatchQueue(label: "queue2", qos: .unspecified, attributes: .concurrent)
        queue2.async {
            semaphore.wait()
            for j in 20..<30 {
                print("🐶：\(j)")
            }
            semaphore.signal()
        }
        
//        let queue3 = DispatchQueue(label: "queue3", qos: .unspecified, attributes: .concurrent)
//        queue3.async {
//            semaphore.wait()
//            for k in 30..<40 {
//                print("🐖：\(k)")
//            }
//            semaphore.signal()
//        }
        
        let queue4 = DispatchQueue(label: "queue4", qos: .unspecified, attributes: .concurrent)
        queue4.async {
            semaphore.wait()
            for z in 50..<60 {
                print(z)
            }
            semaphore.signal()
        }
    }
    
    //OperationQueue【设置最大并发数量】
    func simpleTest8() {
        let operation = OperationQueue()
        
        //设置最大并发数量
        operation.maxConcurrentOperationCount = 2
        
        operation.addOperation {
            for i in 0..<20 {
                print("🐱：\(i)")
            }
        }
        
        operation.addOperation {
            for j in 20..<30 {
                print("🐶：\(j)")
            }
        }
        
        operation.addOperation {
            for k in 40..<50 {
                print("🐖：\(k)")
            }
        }
    }
    
    //设置依赖关系
    func simpleTest9() {
        let queue = OperationQueue()
        
        let blockOperation1 = BlockOperation {
            for i in 0..<10 {
                print("🐱：\(i)")
            }
        }
        
        let blockOperation2 = BlockOperation {
            for j in 20..<30 {
                print("🐶：\(j)")
            }
        }
        
        let blockOperation3 = BlockOperation {
            for k in 40..<50 {
                print("🐖：\(k)")
            }
        }
        
//        blockOperation3.addDependency(blockOperation1)
//        blockOperation3.addDependency(blockOperation2)
        
        queue.addOperation(blockOperation1)
        queue.addOperation(blockOperation2)
//        operation.addOperation(blockOperation3)
        
        

    }
}
