//
//  SwiftForward04.swift
//  Demo
//
//  Created by 王云 on 2018/4/9.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var username: String?
    var age: Int?
    var weight: Double?
    var array: [Any]?
    var dictionary: [String: Any] = [:]
    var bestFriend: User?
    var friends: [User]?
    var birthday: Date?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        array       <- map["arr"]
        dictionary  <- map["dict"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
    }
}


struct Temperature: Mappable {
    
    var celsius: Double?
    var fahrenheit: Double?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        celsius     <- map["celsius"]
        fahrenheit  <- map["fahrenheit"]
    }
}

class Tea: Codable {
    let name: String
    let date: String
    let place: String
    let puer: PuEr
    let teas: [PuEr]
    
    enum CodingKeys: String, CodingKey {
        case name
        case place
        case date = "product_date"
        case puer
        case teas
    }
}

class PuEr: Codable {
    let name: String
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case date = "product_date"
    }
}

class SwiftForward04: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "字典转模型"
        view.backgroundColor = UIColor.white
        
        mappableClassTest()
        mappableStructTest()
        
        let jsonString = "{\"name\": \"普洱\", \"product_date\": \"1990\", \"place\": \"广东\", \"puer\": {\"name\": \"PuEr\", \"product_date\": \"2000\"}, \"teas\": [{\"name\": \"PuEr\", \"product_date\": \"2001\", \"你好\": \"hha\"}, {\"name\": \"PuEr\", \"product_date\": \"2002\"}, {\"name\": \"PuEr\"}, {\"name\": \"PuEr\", \"product_date\": null}]}"
        let tea = try? JSONDecoder().decode(Tea.self, from: jsonString.data(using: .utf8)!)
        print(tea?.name, tea?.date, tea?.place, tea?.puer.name, tea?.puer.date, tea?.teas.count, tea?.teas.last?.date)
        
    }
    
    func mappableClassTest() {
        let jsonDict: [String: Any] = ["username": "zhangsan", "age": 20, "weight": 176.0, "arr": ["eat", "sing", "swimming"], "dict": ["a": "a1", "b": "b1"], "birthday": "1990-12-2"]
        let user = User(JSON: jsonDict)
        print(user?.username, user?.age, user?.weight, user?.array, user?.dictionary, user?.birthday)
        
        let json = user?.toJSON()
        print(json)
        
        let user1 = User(JSONString: "{\"dict\":{\"b\":\"b1\",\"a\":\"a1\"},\"age\":20,\"weight\":176,\"birthday\":1990,\"arr\":[\"eat\",\"sing\",\"swimming\"],\"username\":\"zhangsan\"}")
        print(user1)
        
        let json1 = user1?.toJSONString()
        print(json1)
    }
    
    func mappableStructTest() {
        let tem1 = Temperature(JSONString: "{\"celsius\": 20.0, \"fahrenheit\": 32.8}")
        print(tem1?.celsius, tem1?.fahrenheit)
        
    }

}
