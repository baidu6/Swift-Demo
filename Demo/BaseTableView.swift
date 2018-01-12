//
//  BaseTableView.swift
//  Demo
//
//  Created by 王云 on 2017/11/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
  
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 0.01))
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 0.01))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

enum TipsViewType {
    case icon
    case iconDetail
    case iconButton
    case iconButtonDetail
    
    func tipsView(iconName: String, tips: String, detail: String, buttonTitle: String) -> TableBaseTipView {
        switch self {
        case .icon:
            let tipView = TableBaseTipView()
            tipView.config(iconName: iconName, tips: tips)
            return tipView
        case .iconDetail:
            let tipView = TableTipViewWithDetail()
            tipView.config(iconName: iconName, tips: tips, detail: detail)
            return tipView
        case .iconButton:
            let tipView = TableTipViewWithButton()
            tipView.config(iconName: iconName, tips: tips, buttonTitle: buttonTitle)
            return tipView
        case .iconButtonDetail:
            let tipView = TableTipViewWithButtonDetail()
            tipView.config(iconName: iconName, tips: tips, buttonTitle: buttonTitle, detail: detail)
            return tipView
        }
    }
}

var UITableTipViewParamKey = "UITableTipViewParamKey"
extension UITableView {
    var tipView: TableBaseTipView? {
        get {
            return objc_getAssociatedObject(self, &UITableTipViewParamKey) as? TableBaseTipView
        }
        set(view) {
            objc_setAssociatedObject(self, &UITableTipViewParamKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func createTipView(tipType: TipsViewType = .icon, iconName: String = "failure_bg", tips: String = "没有该类订单！", detail: String = "", buttonTitle: String = "确定", buttonSelected: SimpleCallBack? = nil) -> TableBaseTipView? {
       
        tipView = tipType.tipsView(iconName: iconName, tips: tips, detail: detail, buttonTitle: buttonTitle)
        tipView?.callBack = buttonSelected
        self.addSubview(tipView!)
        
        tipView?.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        return tipView
    }
    
    func hideTipView() {
        guard let tipView = tipView else {
            return 
        }
        tipView.removeFromSuperview()
    }
}

class TableBaseTipView: UIView {
    
    var iconView: UIImageView!
    var tipsLabel: UILabel!
    
    var iconName: String = ""
    var tips: String = ""
    var detail: String = ""
    var buttonTitle: String = ""
    
    var callBack: SimpleCallBack?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(iconName: String, tips: String) {
        iconView.image = UIImage(named: iconName)
        tipsLabel.text = tips
    }
 
    func setupUI() {
        iconView = UIImageView()
        addSubview(iconView)
        
        tipsLabel = UILabel()
        tipsLabel.font = UIFont.systemFont(ofSize: 13)
        tipsLabel.textColor = UIColor.black
        tipsLabel.textAlignment = .center
        addSubview(tipsLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(165)
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
}


class TableTipViewWithButton: TableBaseTipView {
    var button: UIButton!
    
    override func setupUI() {
        super.setupUI()
        
        button = UIButton(type: .custom)
        button.setTitle("确定", for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named: "button_bg"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        
        iconView.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-130)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(165)
        }
    }
    
    @objc func buttonDidClick() {
        callBack?()
    }
    
    convenience init(iconName: String = "failure_bg", tips: String = "没有该类订单！", buttonTitle: String = "确定") {
        self.init(iconName: iconName, tips: tips)
        
        self.buttonTitle = buttonTitle
    }
    
    func config(iconName: String, tips: String, buttonTitle: String) {
        self.config(iconName: iconName, tips: tips)
        button.setTitle(buttonTitle, for: .normal)
    }
}

class TableTipViewWithDetail: TableBaseTipView {
    var detailLabel: UILabel!
    
    override func setupUI() {
        super.setupUI()
        
        detailLabel = UILabel()
        detailLabel.textColor = UIColor.lightGray
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
    }
    
    func config(iconName: String, tips: String, detail: String) {
        self.config(iconName: iconName, tips: tips)
        detailLabel.text = detail
    }
}

class TableTipViewWithButtonDetail: TableTipViewWithButton {
    
    var detailLabel: UILabel!
    
    override func setupUI() {
        super.setupUI()
        
        detailLabel = UILabel()
        detailLabel.textColor = UIColor.lightGray
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        button.snp.remakeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
    }
    
    
    func config(iconName: String, tips: String, buttonTitle: String, detail: String) {
        self.config(iconName: iconName, tips: tips, buttonTitle: buttonTitle)
        detailLabel.text = detail
    }
}
