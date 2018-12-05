//
//  CoreImageTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/7/31.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
typealias Filter = (CIImage) -> CIImage

infix operator ???
func ???<T>(optional: T?, defaultValue: T) -> T {
    if let x = optional {
        return x
    } else {
        return defaultValue
    }
}

class CoreImageTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let orginalIconView = UIImageView(frame: CGRect(x: 30, y: 60, width: SCREEN_WIDTH - 60, height: 300))
        orginalIconView.contentMode = .scaleAspectFill
        view.addSubview(orginalIconView)
        
        let resultIconView = UIImageView(frame: CGRect(x: 30, y: 400, width: SCREEN_WIDTH - 60, height: 300))
        resultIconView.contentMode = .scaleAspectFill
        view.addSubview(resultIconView)
        
        let ciImage = CIImage(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: ".jpg")!))
        
        let originalImage = UIImage(ciImage: ciImage!)
        orginalIconView.image = originalImage
        
//        if #available(iOS 11.0, *) {
//            resultIconView.image = UIImage(ciImage: (ciImage?.applyingFilter("CIGaussianBlur"))!)
//            return
//        } else {
//            // Fallback on earlier versions
//        }
//
        let resultCIImage = blur(radius: 3)(ciImage!)
        let resultImage = UIImage(ciImage: resultCIImage)
        resultIconView.image = resultImage
        
        
        print(add(x: 1, y: 2))
        print(add2(x: 1)(2))
        
        let result = computeArray(arr: [1, 2, 3]) { $0 + 3 }
        print(result)
        
        let a: Int? = nil
        print(a ??? 1)
        
    }
    
    
    func computeArray(arr: [Int], transform: (Int) -> Int) -> [Int] {
        var result: [Int] = []
        for x in arr {
            result.append(transform(x))
        }
        return result
    }
    
    //MARK:- 柯里化
    func add(x: Int, y: Int) -> Int {
        return x + y
    }
    func add2(x: Int) -> (Int) -> Int {
        return { y in
            return x + y
        }
    }
    
    //MARK:- 高斯模糊
    func blur(radius: Double) -> Filter {
        return { image in
            let parameters: [String : Any] = [kCIInputRadiusKey: radius,
                                              kCIInputImageKey: image
                ]
            guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {
                fatalError()
            }
            guard let outputImage = filter.outputImage else {
                fatalError()
            }
            return outputImage
        }
    }
}
