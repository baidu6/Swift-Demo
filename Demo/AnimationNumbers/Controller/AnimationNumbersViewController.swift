//
//  AnimationNumbersViewController.swift
//  Demo
//
//  Created by 王云 on 2017/10/31.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class AnimationNumbersViewController: UIViewController {
    
    fileprivate var animationLabel: AnimationNumbersLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        test()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "数字动画"
        
        animationLabel = AnimationNumbersLabel()
       
   
        view.addSubview(animationLabel)
        if #available(iOS 11.0, *) {
            animationLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(self.view.safeAreaLayoutGuide)
                make.width.equalTo(200)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(50)
            })
        }else {
            animationLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(self.view)
                make.width.equalTo(200)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(50)
            })
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.positiveFormat = "###,##0.00"
        animationLabel.numFormat = formatter

        animationLabel.startAnimation(0, 10000, 3.0)
        
//        action(Person())
//        action(Teacher())

    }
    
    //泛型测试
    func action<T: BasicAction>(_ obj: T) {
        obj.drink()
        obj.eat()
        obj.sleep()
    }
    
    func test() {
        //服务器请求数据
        let datas: [String: Any] = [
            "level": 1,
            "title": "hhahah",
            "urls":[
                "a": "aaaaa",
                "b": "bbbb",
                "c": "cccc"
            ]
        ]
        let model = Episode(reponse: datas)
        print(model?.level, model?.title, model?.urls)
    }
}

protocol BasicAction {
    func eat()
    func sleep()
    func drink()
}
//class Person: BasicAction {
//    func eat() {
//        print("Person--eat")
//    }
//    func sleep() {
//        print("Person--sleep")
//    }
//    func drink() {
//        print("Person--drink")
//    }
//}
class Teacher: BasicAction{
    func eat() {
        print("Teacher--eat")
    }
    func sleep() {
        print("Teacher--sleep")
    }
    func drink() {
        print("Teacher--drink")
    }
}

//网络请求臃肿的代码
enum Level: Int {
    case lower = 1, middle, higher
}
class Episode {
    typealias EpisodeInfo = [String: String]
    
    var level: Level
    var title: String
    var urls: EpisodeInfo
    
    
    init(level: Level, title: String, urls: EpisodeInfo) {
        self.level = level
        self.title = title
        self.urls = urls
    }
    convenience init?(reponse:[String: Any]) {
        guard let levelValue = reponse["level"] as? Int,
            let level = Level(rawValue: levelValue),
            let title = reponse["title"] as? String,
            let urls = reponse["urls"] as? EpisodeInfo else {
                
            return nil
        }
        self.init(level: level, title: title, urls: urls)
    }
    
    
    
}

struct Point: BasicAction {
    
}
extension Point {
    func drink() {
        print("drink")
    }
    func eat() {
        print("eat")
    }
    func sleep() {
        print("sleep")
    }
}







