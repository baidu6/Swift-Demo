//
//  CameraTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/5/30.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CameraTestViewController: UIViewController {
    
    private var imageView: UIImageView!
    
    private var footerView: UIView!
    private var originPosition: CGPoint = CGPoint.zero
    private var targetPosition: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "自定义相机"
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        
//        imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 500))
//        imageView.contentMode = .scaleAspectFit
//        view.addSubview(imageView)
        
        
        footerView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 200))
        footerView.backgroundColor = UIColor.red
        view.addSubview(footerView)
        
        originPosition = footerView.center
        targetPosition = CGPoint(x: footerView.center.x, y: footerView.center.y + footerView.height)
        footerView.layer.position = targetPosition
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = CustomCameraViewController()
//        vc.delegate = self
//        self.present(vc, animated: true, completion: nil)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.25
        animation.fromValue = NSValue(cgPoint: footerView.layer.position)
        animation.toValue = NSValue(cgPoint: originPosition)
        footerView.layer.add(animation, forKey: "positionAnimation")
        footerView.layer.position = originPosition
    }

}

extension CameraTestViewController: CameraViewDelegate {
    func cameraViewDidConfirm(controller: CustomCameraViewController, withImage image: UIImage?) {
        
        imageView.image = image
        
    }
    func cameraViewDidCancel(controler: CustomCameraViewController) {
        
    }
}
