//
//  AnimationTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/28.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class AnimationTestViewController: UIViewController {
    private var mainView: MainView!
    
    private var percent: Double = 0.45

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        mainView = MainView()
        mainView.layer.cornerRadius = 6
        mainView.backgroundColor = UIColor.blue
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(autoWidth(width: 300))
            make.height.equalTo(autoHeight(height: 300))
        }
        
        
        var transform3D   = CATransform3DIdentity
        
        transform3D.m34 = -1 / 500
        
        transform3D = CATransform3DRotate(transform3D, CGFloat(Double.pi * 0.45), 0, 1, 0)
        
        mainView.layer.transform = transform3D
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        percent -= 0.02
        
        var transform3D   = CATransform3DIdentity
        
        transform3D.m34 = -1 / 500
        
        transform3D = CATransform3DRotate(transform3D, CGFloat(Double.pi * percent), 0, 1, 0)
        
        mainView.layer.transform = transform3D
    }

}

class MainView: UIView {
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel = UILabel()
        titleLabel.text = "-----"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.text = "今天是个好日子，心想的事儿都能成。明天也是好日子，什么好事都能成！"
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.textColor = UIColor.white
        addSubview(detailLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoHeight(height: 50))
            make.centerX.equalToSuperview()
        }

        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 50))
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
