//
//  RealmTestViewController.swift
//  Demo
//
//  Created by 王云 on 2017/10/27.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTestViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Realm Test"
        view.backgroundColor = UIColor.white
        
        let realm = try! Realm()
        print(realm.configuration)

        let p = realm.objects(Person.self)
        print(p.count)
        let d = realm.objects(Dog.self)
        print(d.count)
        
        return

        
        let myDog = Dog()
        myDog.name = "canader"
        myDog.key = 1
        myDog.age = 20
  
        //增
        try! realm.write {
            realm.add(myDog)
//            realm.add(myDog, update: true)
        }
        
//        try! realm.write {
//            realm.delete(myDog)
//            realm.deleteAll()
//        }
//
        
//        try! realm.write {
//            myDog.name = "JACK"
//        }
        
        
//        //通过ID=1更新
//        try! realm.write {
//            realm.create(Dog.self, value: ["key":1, "age": 30], update: true)
//        }
        
        //通过键值编码修改属性
//        try! realm.write {
//            myDog.setValue("xiao li zi", forKeyPath: "name")
//        }
//        print(myDog.name)
//        return
        
        
        //查
        
//        let result = realm.objects(Dog.self).filter("age > 0")
//
//        for i in 0..<result.count {
//            let dog1 = result[i]
//            try! realm.write {
//                dog1.age = 2
//            }
//        }
        
        //删
//        try! realm.write {
//            realm.delete(result)
//        }
        
        let dog2 = Dog()
        dog2.name = "dog2"
        dog2.age = 10
        dog2.key = 2
        
        let person1 = Person()
        person1.name = "wangwu"
        person1.age = 20
        person1.isEat = true
        person1.dogs.append(myDog)
        person1.dogs.append(dog2)
        try! realm.write {
            realm.add(person1)
        }
        
        let result = realm.objects(Person.self)
        print(result.count)
        for i in 0..<result.count {
            let p = result[i]
            print(p.name, p.dogs.count)
        }
        
        //查询
        let persons = realm.objects(Person.self).filter("age == 20")
        for i in 0..<persons.count {
            let p = persons[i]
            try! realm.write {
              p.name = "modifity"
            }
            print(p.name)
        }
        
//        //删除元素
//        try! realm.write {
//            realm.delete(persons)
//        }
        
        
        //数据库迁移（在appDelegate里面实现）
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let realm = try! Realm()
        let p = realm.objects(Person.self)
        print(p.count)
        let d = realm.objects(Dog.self)
        print(d.count)
    }

}


class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var key = 0
    override static func primaryKey() -> String? {
        return "key"
    }
}
 
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var isEat = false
    var dogs = List<Dog>()
}

