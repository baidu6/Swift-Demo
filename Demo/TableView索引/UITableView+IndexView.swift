//
//  UITableView+IndexView.swift
//  Demo
//
//  Created by 王云 on 2017/12/26.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
private var IndexViewParamKey = "IndexViewParamKey"

extension UITableView {
    
    var indexView: CustomIndexView? {
        set(view) {
            objc_setAssociatedObject(self, &IndexViewParamKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &IndexViewParamKey) as? CustomIndexView
        }
    }
    
    func customIndexView(indexTitles: [String]) {
        indexView = CustomIndexView(indexTitles: indexTitles)
        self.superview?.addSubview(indexView!)
        
        indexView?.selectedSection = { [weak self] section in
            self?.scrollToRow(at: IndexPath(item: 0, section: section), at: UITableViewScrollPosition.top, animated: false)
        }
    }

}


//MARK:- 自定义IndexView
class CustomIndexView: UIView {
    
    typealias SimpleCallBackWithInt = (_ index: Int) -> ()
    var selectedSection: SimpleCallBackWithInt?
    
    private var tipLabel: UILabel!
    
    private var indexTitles: [String] = [String]()
    private var itemHeight: CGFloat = 30
    private var itemWidth: CGFloat = 40
    private var tipLabelWidth: CGFloat = 60
    
    private var Tag = 11111
    private let fontSize = UIFont.systemFont(ofSize: 16)
    private let animationDuration: TimeInterval = 0.25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect = CGRect.zero, indexTitles: [String]) {
        
        self.init(frame: frame)
        self.indexTitles = indexTitles
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor.lightGray
        setupLabels()
        setupTipLabel()
    }
    
    func setupTipLabel() {
        tipLabel = UILabel(frame: CGRect(x: -tipLabelWidth - 20, y: 0, width: tipLabelWidth, height: tipLabelWidth))
        tipLabel.font = fontSize
        tipLabel.textAlignment = .center
        tipLabel.textColor = UIColor.black
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.layer.cornerRadius = tipLabelWidth * 0.5
        tipLabel.layer.masksToBounds = true
        tipLabel.alpha = 0
        self.addSubview(tipLabel)
    }
    
    func setupLabels() {
        let itemX: CGFloat = 0
        var itemY: CGFloat = 0
        for i in 0..<indexTitles.count {
            let label = UILabel(frame: CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight))
            label.text = indexTitles[i]
            label.tag = Tag + i
            label.textAlignment = .center
            label.textColor = UIColor.black
            label.font = fontSize
            
            addSubview(label)
            
            itemY += itemHeight
            
            if i == indexTitles.count - 1 {
                self.frame.size.height = itemY
            }
        }
        
        self.frame = CGRect(x: ScreenWidth - itemWidth, y: 0, width: itemWidth, height: itemY)
        self.center.y = ScreenHeight * 0.5
        
    }
    
    func showTipsLabel(section: Int, centerY: CGFloat) {
        guard let tipLabel = self.tipLabel else { return }
        
        selectedSection?(section)
        tipLabel.text = self.indexTitles[section]
        tipLabel.center.y = centerY
        
        UIView.animate(withDuration: animationDuration, animations: {
            tipLabel.alpha = 1

        })
    }
    
    func panAnimationWithTouches(touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        for i in 0..<indexTitles.count {
            if let label = self.viewWithTag(Tag + i) {
                if label.frame.contains(point) {
                    showTipsLabel(section: i, centerY: label.center.y)
                }
            }
        }
    }
    
    func panAnimationFinished() {
        guard let tipLabel = self.tipLabel else { return }
        
        UIView.animate(withDuration: animationDuration, animations: {
            tipLabel.alpha = 0
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationWithTouches(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationWithTouches(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationFinished()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationFinished()
    }
    
    deinit {
        self.tipLabel.removeFromSuperview()
        self.removeFromSuperview()
        self.selectedSection = nil
    }
}



