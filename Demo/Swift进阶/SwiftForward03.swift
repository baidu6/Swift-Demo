//
//  SwiftForward03.swift
//  Demo
//
//  Created by 王云 on 2018/4/8.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class VolumTool {
    
    static private let duration: TimeInterval = 2.0
    
    static private var volumSlider: UIProgressView = {
        let volumSlider = UIProgressView(frame: CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 20))
        volumSlider.tintColor = UIColor.black
        volumSlider.trackTintColor = UIColor.lightGray
        volumSlider.progressViewStyle = .default
        return volumSlider
    }()
    
    static func showVolumSlider(_ volum: Float?) {
        guard let volum = volum else {
            return
        }
        
        volumSlider.progress = volum
        UIApplication.shared.keyWindow?.addSubview(volumSlider)
        UIView.animate(withDuration: duration, animations: {
            volumSlider.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20)
        }) { (_) in
            volumSlider.removeFromSuperview()
        }
    }
    
    static func hideVolumSlider() {
        UIView.animate(withDuration: duration) {
            volumSlider.removeFromSuperview()
        }
    }
}

class SwiftForward03: UIViewController {
    
    var backView: SendBackView!
    var scrollView: UIScrollView!
    
    private lazy var volumSlider: UIProgressView = {
        let volumSlider = UIProgressView(frame: CGRect(x: 0, y: -40, width: SCREEN_WIDTH, height: 20))
        volumSlider.backgroundColor = UIColor.red
        return volumSlider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
 
        //添加声音监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(noti:)), name: Notification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        //隐藏系统的音量提示框
        let volumView = MPVolumeView(frame: CGRect(x: -SCREEN_WIDTH, y: -SCREEN_HEIGHT, width: 100, height: 100))
        view.addSubview(volumView)
        
        
        //申请退回
        setupUI()
    }

    
    @objc func volumeChanged(noti: Notification) {
        let volum = noti.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float
        VolumTool.showVolumSlider(volum)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.endReceivingRemoteControlEvents()
    }
}

extension SwiftForward03 {

    func setupUI() {
        
        scrollView = UIScrollView(frame: view.bounds)
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        scrollView.contentInset = UIEdgeInsetsMake(88, 0, 0, 0)
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backView = SendBackView()
        scrollView.addSubview(backView)
      
        backView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
        }
    }
}

class SendBackView: UIView {

    private var contactPerson: CustomField!
    private var contactWay: CustomField!
    private var reasonView: BackReasonView!
    private var customTextView: CustomTextView!
    private var submitBtn: UIButton!
    
    private var textView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
    
        contactPerson = CustomField(title: "联系人：")
        addSubview(contactPerson)
        
        contactWay = CustomField(title: "联系方式：")
        addSubview(contactWay)
        
        reasonView = BackReasonView()
        addSubview(reasonView)
        
        customTextView = CustomTextView()
        addSubview(customTextView)
        
        submitBtn = UIButton()
        submitBtn.setTitle("提交", for: UIControlState.normal)
        submitBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        submitBtn.backgroundColor = UIColor.lightGray
        addSubview(submitBtn)
       
        
        contactPerson.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(autoHeight(height: 100))
        }
        
        contactWay.snp.makeConstraints { (make) in
            make.top.equalTo(contactPerson.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(autoHeight(height: 100))
        }
        
        reasonView.snp.makeConstraints { (make) in
            make.top.equalTo(contactWay.snp.bottom).offset(autoHeight(height: 20))
            make.left.right.equalToSuperview()
        }
        
        customTextView.snp.makeConstraints { (make) in
            make.top.equalTo(reasonView.snp.bottom).offset(autoHeight(height: 20))
            make.left.right.equalToSuperview()
            make.height.equalTo(autoHeight(height: 800))
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(customTextView.snp.bottom).offset(autoHeight(height: 30))
            make.height.equalTo(autoHeight(height: 100))
        }
        
    }
}

class CustomField: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    private var titleLabel: UILabel!
    private var contentField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.lightGray
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
        
        contentField = UITextField()
        contentField.font = UIFont.systemFont(ofSize: 15)
        contentField.textAlignment = .right
        addSubview(contentField)
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        addSubview(line)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoWidth(width: 20))
            make.centerY.equalToSuperview()
            make.width.equalTo(autoWidth(width: 200))
        }
        
        contentField.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalToSuperview().offset(autoWidth(width: -20))
            make.top.bottom.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalToSuperview()
            make.height.equalTo(autoHeight(height: 1))
            make.right.equalTo(contentField.snp.right)
        }
    }
}

class CustomTextView: UIView {
    
    private var titleLabel: UILabel!
    private var textView: UITextView!
    private var countLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel = UILabel()
        titleLabel.text = "备注："
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.lightGray
        addSubview(titleLabel)
        
        textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(textView)
        
        countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.textAlignment = .right
        countLabel.text = "100/100"
        countLabel.textColor = UIColor.lightGray
        addSubview(countLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(autoWidth(width: 20))
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 20))
            make.left.bottom.equalToSuperview().offset(autoWidth(width: 20))
            make.right.equalToSuperview().offset(autoWidth(width: -20))
        }
        countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(textView.snp.right).offset(autoWidth(width: -10))
            make.bottom.equalTo(textView.snp.bottom).offset(autoHeight(height: -10))
        }
    }
}

class BackReasonView: UIView {
    
    var errorsArray = [BackErrorType.houseInfo.rawValue, BackErrorType.obligee.rawValue, BackErrorType.other.rawValue, BackErrorType.houseInfo.rawValue, BackErrorType.obligee.rawValue]
    var lastBtnTag: Int = 0
    
    private var titleLabel: UILabel!
    private var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.text = "退回原因："
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.lightGray
        addSubview(titleLabel)
        
        contentView = UIView()
        addSubview(contentView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(autoWidth(width: 20))
        }
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoHeight(height: 20))
            make.left.right.bottom.equalToSuperview()
        }
        
        createBtns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBtns() {
        let totalCol = 3
        let gap: CGFloat = autoWidth(width: 10)
        let btnW: CGFloat = (SCREEN_WIDTH - autoWidth(width: 80) - CGFloat((totalCol - 1)) * gap) / 3
        let btnH: CGFloat = autoHeight(height: 80)
        for i in 0..<errorsArray.count {
            let btn = UIButton(type: .custom)
            let col = i % totalCol
            let row = i / totalCol
            btn.frame = CGRect(x: (btnW + gap) * CGFloat(col) + autoWidth(width: 40), y: (btnH + gap) * CGFloat(row), width: btnW, height: btnH)
            btn.setTitle(errorsArray[i], for: UIControlState.normal)
            btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            btn.setTitleColor(UIColor.orange, for: UIControlState.selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.backgroundColor = UIColor.lightGray
            btn.tag = 10000 + i
            btn.addTarget(self, action: #selector(btnDidClick(btn:)), for: UIControlEvents.touchUpInside)
            contentView.addSubview(btn)
            
            lastBtnTag = 10000
            
            if i == errorsArray.count - 1 {
                contentView.snp.makeConstraints({ (make) in
                    make.height.equalTo(btn.frame.maxY)
                })
            }
        }
    }
    
    @objc func btnDidClick(btn: UIButton) {
        
        if btn.isSelected == true {
            return
        }
        
        let lastBtn = self.viewWithTag(lastBtnTag) as? UIButton
        lastBtn?.isSelected = false
        
        btn.isSelected = !btn.isSelected
        
        lastBtnTag = btn.tag
    }
}

enum BackErrorType: String {
    case houseInfo = "房产信息错误"
    case obligee = "权利人错误"
    case other = "其它"
}



