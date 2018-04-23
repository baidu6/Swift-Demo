//
//  CustomAlertTool.swift
//  Demo
//
//  Created by 王云 on 2018/4/19.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

enum CustomAlertType {
    case title //标题+确定按钮
    case detail //标题+详情+确定按钮
    case titleCancel //标题+确定+取消
    case detailCancel //标题+详情+确定+取消
    
    static func createAlertViewWith(_ type: CustomAlertType) -> AlertBaseView {
        switch type {
        case .title:
            return AlertTitleView(frame: UIScreen.main.bounds)
        case .detail:
            return AlertDetailView(frame: UIScreen.main.bounds)
        case .titleCancel:
            return AlertTitleCancelView(frame: UIScreen.main.bounds)
        case .detailCancel:
            return AlertDetailCancelView(frame: UIScreen.main.bounds)
        }
    }
    
}

class CustomAlertTool: NSObject {
    
    private static let duration: TimeInterval = 0.25
    private static var alertView: AlertBaseView!
    
    private static var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindowLevelAlert + 2
        window.backgroundColor = UIColor.clear
        return window
    }()

    static func alertShow(alertType: CustomAlertType = .detail) {
        alertView = CustomAlertType.createAlertViewWith(alertType)
        alertView.alpha = 0
        window.isHidden = false
        window.addSubview(alertView)
        
        alertView.startShow()
        UIView.animate(withDuration: duration) {
            alertView.alpha = 1
        }
    }
    
    static func alertHidden() {
        UIView.animate(withDuration: duration, animations: {
            alertView.alpha = 0
        }) { (_) in
            alertView.removeFromSuperview()
            window.isHidden = true
        }
    }
}

class AlertBaseView: UIView {
    
    typealias SimpleCallBack = () -> ()
    var certainBtnClick: SimpleCallBack?
    var cancelBtnClick: SimpleCallBack?

    var contentView: UIView!
    var title: String = "提示"
    var detail: String = "--"
    var certainStr: String = "确定"
    var cancelStr: String = "取消"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
        addGestureRecognizer(tap)

        addContentView()
    }
  
    func addContentView() {
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - autoWidth(width: 120))
            make.center.equalToSuperview()
        }
        
    }
    
    func startShow() {
        
        contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.contentView.transform = CGAffineTransform.identity
            self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }, completion: { (_) in
            
        })
    }
    
    //MARK:- 点击确定按钮
    @objc func certainBtnDidClick() {
        tapToDismiss()
        certainBtnClick?()
    }
    //MARK:- 点击取消按钮
    @objc func cancelBtnDidClick() {
        tapToDismiss()
        cancelBtnClick?()
    }
    //MARK:- 点击屏幕消失
    @objc func tapToDismiss() {
        CustomAlertTool.alertHidden()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AlertTitleView: AlertBaseView {
    
    fileprivate var titleLabel: UILabel!
    fileprivate var certainBtn: UIButton!
    
    override func addContentView() {
        super.addContentView()
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        certainBtn = UIButton()
        certainBtn.setTitle(certainStr, for: .normal)
        certainBtn.setTitleColor(UIColor.white, for: .normal)
        certainBtn.backgroundColor = UIColor.orange
        certainBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        certainBtn.addTarget(self, action: #selector(certainBtnDidClick), for: .touchUpInside)
        contentView.addSubview(certainBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoHeight(height: 20))
            make.left.equalToSuperview().offset(autoWidth(width: 20))
            make.right.equalToSuperview().offset(autoWidth(width: -20))
        }

        certainBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 60))
            make.left.right.equalToSuperview()
            make.height.equalTo(autoHeight(height: 100))
            make.bottom.equalToSuperview()
        }
        
    }

}

class AlertDetailView: AlertTitleView {
    
    fileprivate var detailLabel: UILabel!
    
    override func addContentView() {
        super.addContentView()
        
        titleLabel.text = title
        
        detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.textAlignment = .center
        detailLabel.textColor = UIColor.lightGray
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 10))
            make.left.right.equalTo(titleLabel)
        }
        
        certainBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(autoHeight(height: 20))
            make.height.equalTo(autoHeight(height: 100))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}

class AlertTitleCancelView: AlertBaseView {
   
    fileprivate var titleLabel: UILabel!
    fileprivate var cancelBtn: UIButton!
    fileprivate var certainBtn: UIButton!
    fileprivate var line: UIView!
    
    override func addContentView() {
        super.addContentView()
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        cancelBtn = UIButton()
        cancelBtn.setTitle(cancelStr, for: .normal)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.backgroundColor = UIColor.orange
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelBtn.addTarget(self, action: #selector(cancelBtnDidClick), for: .touchUpInside)
        contentView.addSubview(cancelBtn)
        
        line = UIView()
        line.backgroundColor = UIColor.lightGray
        contentView.addSubview(line)
        
        certainBtn = UIButton()
        certainBtn.setTitle(certainStr, for: .normal)
        certainBtn.setTitleColor(UIColor.white, for: .normal)
        certainBtn.backgroundColor = UIColor.orange
        certainBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        certainBtn.addTarget(self, action: #selector(certainBtnDidClick), for: .touchUpInside)
        contentView.addSubview(certainBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoHeight(height: 20))
            make.left.equalToSuperview().offset(autoWidth(width: 20))
            make.right.equalToSuperview().offset(autoWidth(width: -20))
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 20))
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(autoHeight(height: 100))
            make.bottom.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right)
            make.top.equalTo(cancelBtn)
            make.width.equalTo(autoHeight(height: 1))
        }
        
        certainBtn.snp.makeConstraints { (make) in
            make.top.height.width.bottom.equalTo(cancelBtn)
            make.left.equalTo(line.snp.right)
            
        }
    }
}

class AlertDetailCancelView: AlertTitleCancelView {
    
    fileprivate var detailLabel: UILabel!
    
    override func addContentView() {
        super.addContentView()
        
        detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.textAlignment = .center
        detailLabel.textColor = UIColor.lightGray
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 10))
            make.left.right.equalTo(titleLabel)
        }
        
        cancelBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(autoHeight(height: 20))
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(autoHeight(height: 100))
            make.bottom.equalToSuperview()
        }
        
        line.snp.remakeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right)
            make.top.equalTo(cancelBtn)
            make.width.equalTo(autoHeight(height: 1))
        }
        
        certainBtn.snp.remakeConstraints { (make) in
            make.top.height.width.bottom.equalTo(cancelBtn)
            make.left.equalTo(line.snp.right)
            
        }
    }

}

