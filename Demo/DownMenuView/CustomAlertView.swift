//
//  DownMenuView.swift
//  Demo
//
//  Created by 王云 on 2018/1/24.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
private let buttonHeight: CGFloat = 40

class CustomAlertBaseView: UIView {
 
    var contentView = UIView()
    private var animationDuration: TimeInterval = 0.25
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.alpha = 0
        contentView.center = center
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.white
        contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func showMenuView() {
        UIApplication.shared.keyWindow?.addSubview(self)

        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }, completion: nil)

    }
    
    @objc func dismissMenuView() {

        UIView.animate(withDuration: animationDuration, animations: {
            self.contentView.alpha = 0.0
            self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { (_) in
            self.contentView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissMenuView()
    }
}

//MARK:- 创建只有一个确定按钮的弹窗
class CustomAlertOneButtonView: CustomAlertBaseView {
    let buttonTitleStr: String
    var confirmButton: UIButton!
    
    var confirmButtonDidClick: SimpleCallBack?

    init(buttonTitle: String) {
        buttonTitleStr = buttonTitle

        super.init(frame:  UIScreen.main.bounds)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        super.setupUI()

        confirmButton = UIButton()
        confirmButton.setTitle(buttonTitleStr, for: .normal)
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        confirmButton.backgroundColor = UIColor.blue
        confirmButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        contentView.addSubview(confirmButton)
    }
    
    @objc func clickButton() {
        confirmButtonDidClick?()
        dismissMenuView()
    }
}


class AlertTitleViewWithOneButton: CustomAlertOneButtonView {
    
    //在init里我们可以对let的实例常量进行赋值，这是初始化方法的重要特点。在Swift中let声明的值是不变量，无法被写入赋值，这对于构建线程安全的API十分有用。而因为Swift的init只可能被调用一次，因此在init中我们可以为不变量进行赋值，而不会引起任何线程安全的问题。
    let titleStr: String
    var titleLabel: UILabel!
    
    
    init(title: String, buttonTitle: String) {
        titleStr = title
        
        super.init(buttonTitle: buttonTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel = UILabel()
        titleLabel.text = titleStr
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }
}

class AlertDetailViewWithOneButton: AlertTitleViewWithOneButton {
    let detailStr: String
    var detailLabel: UILabel!
    
    init(title: String, detail: String, buttonTitle: String) {
        detailStr = detail
        
        super.init(title: title, buttonTitle: buttonTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        detailLabel = UILabel()
        detailLabel.text = detailStr
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.textAlignment = .center
        detailLabel.textColor = UIColor.gray
        detailLabel.numberOfLines = 0
        contentView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }
}

class AlertIconViewWithOneButton: CustomAlertOneButtonView {
    let iconStr: String
    
    var iconImageView: UIImageView!
    
    init(icon: String, buttonTitle: String) {
        iconStr = icon
        
        super.init(buttonTitle: buttonTitle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        iconImageView = UIImageView()
        iconImageView.image = UIImage(named: iconStr)
        contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }
}

class AlertIconDetailViewWithOneButton: AlertIconViewWithOneButton {
    let detailStr: String
    var detailLabel: UILabel!
    
    init(icon: String, detail: String, buttonTitle: String) {
        detailStr = detail
        
        super.init(icon: icon, buttonTitle: buttonTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        detailLabel = UILabel()
        detailLabel.text = detailStr
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.textAlignment = .center
        detailLabel.textColor = UIColor.gray
        detailLabel.numberOfLines = 0
        contentView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }
}

//MARK:- 创建有取消，确定两个按钮的弹窗
class CustomAlertTwoButtonView: CustomAlertBaseView {
    
    let confirmTitleStr: String
    let cancelTitleStr: String
    
    var cancelButton: UIButton!
    var confirmButton: UIButton!
    var line: UIView!
    
    var cancelBtnDidClick: SimpleCallBack?
    var confirmBtnDidClick: SimpleCallBack?
    
    init(confirmTitle: String, cancelTitle: String) {
        confirmTitleStr = confirmTitle
        cancelTitleStr = cancelTitle
        
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        confirmButton = UIButton()
        confirmButton.setTitle(confirmTitleStr, for: .normal)
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        confirmButton.backgroundColor = UIColor.blue
        confirmButton.addTarget(self, action: #selector(clickConfirmButton), for: .touchUpInside)
        contentView.addSubview(confirmButton)
        
        cancelButton = UIButton()
        cancelButton.setTitle(cancelTitleStr, for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.backgroundColor = UIColor.blue
        cancelButton.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        line = UIView()
        line.backgroundColor = UIColor.white
        contentView.addSubview(line)
        
    }
    
    @objc func clickConfirmButton() {
        confirmBtnDidClick?()
        dismissMenuView()
    }
    
    @objc func clickCancelButton() {
        cancelBtnDidClick?()
        dismissMenuView()
    }
}

class AlertTitleViewWithTwoButton: CustomAlertTwoButtonView {
    
    let titleStr: String
    var titleLabel: UILabel!
    
    init(title: String, confirm: String = "确定", cancel: String = "取消") {
        titleStr = title
        
        super.init(confirmTitle: confirm, cancelTitle: cancel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel = UILabel()
        titleLabel.text = titleStr
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.width.equalTo(confirmButton)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(cancelButton.snp.right)
            make.width.equalTo(0.5)
            make.top.bottom.equalTo(cancelButton)
        }
    }

}

class AlertDetailViewWithTwoButton: AlertTitleViewWithTwoButton {
    
    let detailStr: String
    var detailLabel: UILabel!
    
    init(title: String, detail: String, confirm: String = "确定", cancel: String = "取消") {
        detailStr = detail
        
        super.init(title: title, confirm: confirm, cancel: cancel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        detailLabel = UILabel()
        detailLabel.text = detailStr
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.textAlignment = .center
        detailLabel.textColor = UIColor.gray
        detailLabel.numberOfLines = 0
        contentView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        cancelButton.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.width.equalTo(confirmButton)
        }
        
        line.snp.remakeConstraints { (make) in
            make.left.equalTo(cancelButton.snp.right)
            make.width.equalTo(0.5)
            make.top.bottom.equalTo(cancelButton)
        }
    }
}


