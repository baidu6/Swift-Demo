//
//  ScrollView+Refresh.swift
//  Demo
//
//  Created by 王云 on 2018/3/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
var ParamKeyRefreshHeader = "Header"
var ParamKeyRefreshFooter = "Footer"
extension UIScrollView {
    weak var refreshHeader: RefreshBaseView? {
        get {
            return objc_getAssociatedObject(self, &ParamKeyRefreshHeader) as? RefreshBaseView
        }
        set(view) {
            objc_setAssociatedObject(self, &ParamKeyRefreshHeader, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func addRefreshHeader(frame: CGRect, headerType: RefreshHeaderViewType = .normal, callback: SimpleCallBack?) -> RefreshHeaderViewBase {
        let header = RefreshBaseView.createHeaderView(frame: frame, headerType: headerType, callback: callback)
        self.refreshHeader = header
        self.addSubview(header)
        return header
    }
    
    @discardableResult
    func addRefreshHeader(headerType: RefreshHeaderViewType = .normal, callback: SimpleCallBack?) -> RefreshHeaderViewBase {
        return addRefreshHeader(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64), headerType: headerType, callback: callback)
    }
    
    func removeRefreshHeader() {
        self.refreshHeader?.removeFromSuperview()
    }
    
    func beginRefreshHeader() {
        self.refreshHeader?.beginRefresh()
    }
    
    func endRefresh() {
        self.refreshHeader?.endRefresh()
    }
}
