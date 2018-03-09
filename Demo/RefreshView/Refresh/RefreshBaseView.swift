//
//  RefreshBaseView.swift
//  Demo
//
//  Created by 王云 on 2018/3/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
let ContentOffset = "contentOffset"
let ContentSize = "contentSize"
enum RefreshState {
    case none
    case normal //普通
    case releaseToRefresh   //松开刷新
    case refreshing //刷新中
}

enum RefreshViewType {
    case header
    case footer
    static func from(_ rawValue: Int) -> RefreshViewType {
        if rawValue == 2 {
            return .footer
        }
        return .header
    }
}

enum RefreshHeaderViewType {
    case normal
    case icon
//    case iconBounce
    case dollar
    case dollarBounce
    
    func headerView(frame: CGRect) -> RefreshHeaderViewBase {
        switch self {
        case .icon:
            return RefreshHeaderViewRotateWithIcon(frame: frame)
       
        default:
            return RefreshHeaderViewDefault(frame: frame)
        }
    }
}

class RefreshBaseView: UIView {
    
    fileprivate var callBack: SimpleCallBack?
    
    static func createHeaderView(frame: CGRect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 64), headerType: RefreshHeaderViewType = .icon, callback: SimpleCallBack? = nil) -> RefreshHeaderViewBase {
        let header = headerType.headerView(frame: frame)
        header.callBack = callback
        return header
    }
    
    var viewTypeRawvalue: Int = 1
    var animationDuration = 0.4
    var animationDelay = 0.0
    var viewType: RefreshViewType = RefreshViewType.header
    var scrollView: UIScrollView!
    var scrollViewOriginalInset: UIEdgeInsets!
    var originalHeight: CGFloat = 0
    var state = RefreshState.none
    var shouldRefresh = true
    var isRefreshing: Bool {
        return self.state == RefreshState.refreshing
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewType = RefreshViewType.from(self.viewTypeRawvalue)
        config()
    }
    
    init(frame: CGRect, viewType: RefreshViewType) {
        super.init(frame: frame)
        self.viewType = viewType
        config()
    }
    
    func config() {
        backgroundColor = UIColor.clear
        originalHeight = frame.size.height
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if self.superview != nil {
            self.superview?.removeObserver(self, forKeyPath: ContentOffset)
        }
        if newSuperview != nil {
            newSuperview?.addObserver(self, forKeyPath: ContentOffset, options: .new, context: nil)
            
            var rect = self.frame
            rect.size.width = (newSuperview?.frame.size.width)!
            rect.origin.x = 0
            self.frame = rect
            
            self.scrollView = newSuperview as! UIScrollView
            scrollViewOriginalInset = self.scrollView.contentInset
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentOffset {
            onContentOffsetChanged()
        }
    }
    
    func onContentOffsetChanged() {}
    func onStateChangeWithOffset(_ offset: CGPoint) {}
    func onNoneFromNormal() {}
    func onNoneFromRefreshing() {}
    func onNormalFromNone() {}
    func onNormalFromRelease() {}
    func onReleaseFromNormal() {}
    func onRefreshing() {}
    
    func beginRefresh() {
        self.state = RefreshState.refreshing
    }
    func endRefresh() {
        var contentInset = self.scrollView.contentInset
        var offsetY: CGFloat = 0
        if viewType == .header {
            contentInset.top = self.scrollViewOriginalInset.top
        }else {
            contentInset.bottom = self.scrollViewOriginalInset.bottom
            let maxOffsetY = computeMaxOffsetY()
            if maxOffsetY > 0 {
                offsetY = maxOffsetY
            }
        }
        UIView.animate(withDuration: animationDuration, animations: { [weak self] () -> Void in
            self?.scrollView.contentInset = contentInset
//            self?.scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
        },completion: { [weak self](flag: Bool) -> Void in
            self?.state = RefreshState.none
        })
    }
    
    fileprivate func computeMaxOffsetY() -> CGFloat {
        let maxOffsetY = self.scrollView.contentSize.height - (self.scrollView.frame.size.height + self.scrollViewOriginalInset.top + self.scrollViewOriginalInset.bottom)
        return maxOffsetY
    }
}

class RefreshHeaderViewBase: RefreshBaseView {
    
    let strPullToRefresh = "下拉刷新"
    let strRefreshing = "加载中..."
    let strReleaseToRefresh = "松开刷新"
    
    override var state: RefreshState {
        didSet {
            if oldValue != RefreshState.refreshing {
                scrollViewOriginalInset = scrollView.contentInset
            }
            if self.state == oldValue {
                return
            }
            switch self.state {
            case .none:
                if oldValue == .normal {
                    onNoneFromNormal()
                }else if oldValue == RefreshState.refreshing {
                    onNoneFromRefreshing()
                }
                break
            case .normal:
                if oldValue == .none {
                    onNormalFromNone()
                }else if oldValue == .releaseToRefresh {
                    onNormalFromRelease()
                }
                break
            case .releaseToRefresh:
                onReleaseFromNormal()
                break
            case .refreshing:
                if shouldRefresh {
                    onRefreshing()
                    UIView.animate(withDuration: animationDuration, animations: {[weak self] () -> Void in
                            self?.refreshEffect()
                        },completion: {[weak self](flag: Bool) -> Void in
                            self?.callBack?()
                    })
                }
                break
            }
        }
    }
        
    fileprivate func refreshEffect() {
        var contentInset = self.scrollView.contentInset
        contentInset.top = self.scrollViewOriginalInset.top + originalHeight
        self.scrollView.contentInset = contentInset
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, viewType: .header)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        adjustFrame()
    }
 
    //MARK:- 调整位置
    func adjustFrame() {
        var rect = self.frame
        rect.origin.y = -rect.size.height - scrollViewOriginalInset.top
        self.frame = rect
    }
    
    override func onContentOffsetChanged() {
        super.onContentOffsetChanged()
        if self.isHidden {
            return
        }
        if shouldRefresh && isRefreshing {
            return
        }
        self.changeStateWithOffset()
    }
    
    fileprivate func changeStateWithOffset() {
        let offsetY = self.scrollView.contentOffset.y + originalHeight
        print(self.scrollView.contentOffset.y)
        let threshold = -scrollViewOriginalInset.top
        if offsetY >= threshold {
            if self.state == .normal {
                self.state = .none
            }else if self.state == .refreshing && !shouldRefresh {
                self.state = .none
            }
            return
        }
        if self.scrollView.isDragging {
            if self.state == .none {
                if offsetY >= threshold - originalHeight {
                    self.state = .normal
                }
            }else if self.state == .normal {
                if offsetY < threshold - originalHeight {
                    self.state = .releaseToRefresh
                }
            }else if self.state == .releaseToRefresh {
                if offsetY >= threshold - originalHeight {
                    self.state = .normal
                }
            }
        }else {
            if self.state == .releaseToRefresh {
                if offsetY >= threshold - originalHeight - 4 {
                    self.state = .refreshing
                    beginRefresh()
                }
            }
        }
        self.onStateChangeWithOffset(CGPoint(x: self.scrollView.contentOffset.x, y: threshold - offsetY))
    }
}

class RefreshFooterViewBase: RefreshBaseView {
    let strPullToRefresh = "上拉加载"
    let strRefreshing = "加载中"
    let strReleaseToRefresh = "松开刷新"
    override var state: RefreshState {
        didSet {
            if oldValue == .refreshing {
                scrollViewOriginalInset = scrollView.contentInset
            }
            if state == oldValue {
                return
            }
            switch self.state {
            case .none:
                if oldValue == .normal {
                    onNoneFromNormal()
                }else if oldValue == .refreshing {
                    onNoneFromRefreshing()
                }
            case .normal:
                if oldValue == .none {
                    onNormalFromNone()
                }else if oldValue == .releaseToRefresh {
                    onNormalFromRelease()
                }
            case .releaseToRefresh:
                onNormalFromRelease()
            case .refreshing:
                if shouldRefresh {
                    onRefreshing()
                    UIView.animate(withDuration: animationDuration, animations: { [weak self] in
                        self?.refreshEffect()
                    }, completion: { [weak self] (_) in
                        self?.callBack?()
                    })
                }
            }
        }
    }
    
    fileprivate func refreshEffect() {
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = self.scrollViewOriginalInset.bottom + self.originalHeight
        self.scrollView.contentInset = contentInset
    }
    
    override init(frame: CGRect, viewType: RefreshViewType) {
        super.init(frame: frame, viewType: .footer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if self.superview != nil {
            self.superview?.removeObserver(self, forKeyPath: ContentOffset)
        }
        if newSuperview != nil {
            newSuperview?.addObserver(self, forKeyPath: ContentOffset, options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == ContentOffset {
            onContentSizeChanged()
        }
    }
    
    func onContentSizeChanged () {
        
    }
}
