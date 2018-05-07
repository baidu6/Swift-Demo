//
//  PhotoBrowser.swift
//  Demo
//
//  Created by 王云 on 2018/5/3.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

public enum PhotoBrowserAnimationType {
    case scale
    case fade
}

public protocol PhotoBrowserDelegate: class {
    
    // required
    //MARK:- 返回图片数量
    func numberOfPhotos(in photoBrowser: PhotoBrowser) -> Int
    
    //MARK:- 返回默认显示图片，缩略图或占位图
    func photoBrowser(_ photoBrowser: PhotoBrowser, imageForIndex index: Int) -> URL?
    
    //MARK:- 返回当前的cell
    func photoBrowser(_ photoBrowser: PhotoBrowser, cellForIndex index: Int) -> UICollectionViewCell?

    //MARK:- 长按时候回调
    func photoBrowser(_ photoBrowser: PhotoBrowser, didLongPressForIndex index: Int, image: UIImage)
    
    //MARK:- 即将关闭浏览器的时候调用
    func photoBrowser(_ photoBrowser: PhotoBrowser, willDismissWithIndex index: Int, image: UIImage?)
    
    //MARK:- 已经关闭浏览器的时候调用
    func photoBrowser(_ photoBrowser: PhotoBrowser, didDismissWithIndex index: Int, image: UIImage?)
}

extension PhotoBrowserDelegate {
    func photoBrowser(_ photoBrowser: PhotoBrowser, willDismissWithIndex index: Int, image: UIImage?) {}

    func photoBrowser(_ photoBrowser: PhotoBrowser, didDismissWithIndex index: Int, image: UIImage?) {}
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, didLongPressForIndex index: Int, image: UIImage) {}
}

public class PhotoBrowser: UIViewController {
    
    public weak var photoBrowserDelegate: PhotoBrowserDelegate?
  
    //左右两张图的间隙
    public var photoSpacing: CGFloat = 30
    
    //图片缩放模式
    public var imageScaleModel = UIViewContentMode.scaleAspectFill
    
    //捏合手势放大图片时的最大允许比例
    public var imageMaximumZoomScale: CGFloat = 2.0
    
    //双击放大图片时的目标比例
    public var imageZoomScaleForDoubleTap: CGFloat = 2.0
    
    //保存原windowLevel
    private lazy var originWindowLevel: UIWindowLevel? = { [weak self] in
        let window = self?.view.window ?? UIApplication.shared.keyWindow
        return window?.windowLevel
    }()
    
    //当前显示的图片序号
    private var currentIndex = 0
    
    //转场动画类型
    private var animationType: PhotoBrowserAnimationType = .scale
    
    //
    private var presentationVC: CustomPresentationController!
    
    //布局
    private lazy var flowLayout: PhotoBrowserLayout = {
        return PhotoBrowserLayout()
    }()
    
    //容器
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoBrowserCell.self, forCellWithReuseIdentifier: NSStringFromClass(PhotoBrowserCell.self))
        return collectionView
        }()
    
    public init(delegate: PhotoBrowserDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.modalPresentationCapturesStatusBarAppearance = true
        
        self.photoBrowserDelegate = delegate
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PhotoBrowser {
    
    public class func show(byViewController presentingVC: UIViewController, delegate: PhotoBrowserDelegate, openIndex: Int) {
        let vc = PhotoBrowser(delegate: delegate)
        vc.setOpenIndex(openIndex)
        vc.show(byViewController: presentingVC)
    }
    
    //MARK:- 打开指定的图片浏览器中的图片
    public func setOpenIndex(_ index: Int) {
        currentIndex = index
    }
    
    //MARK:- 显示图片浏览器
    public func show(byViewController presentingVC: UIViewController) {
        presentingVC.present(self, animated: true, completion: nil)
    }
    
    //MARK:- 关闭图片浏览器
    public func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}

//MARK:- 声明周期及其回调方法
extension PhotoBrowser {
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupViews() {
        flowLayout.minimumLineSpacing = photoSpacing
        flowLayout.itemSize = view.bounds.size
        view.addSubview(collectionView)
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }

}

extension PhotoBrowser: UICollectionViewDelegate, UICollectionViewDataSource {
   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let delegate = photoBrowserDelegate else {
            return 0
        }
        return delegate.numberOfPhotos(in: self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PhotoBrowserCell.self), for: indexPath) as! PhotoBrowserCell
        cell.imageView.contentMode = imageScaleModel
        cell.photoBrowserCellDelegate = self
        cell.imageMaximumZoomScale = imageMaximumZoomScale
        cell.imageZoomScaleForDoubleTap = imageZoomScaleForDoubleTap
        
        if let delegate = photoBrowserDelegate {
            let url = delegate.photoBrowser(self, imageForIndex: indexPath.row)
            cell.setImage(nil, url: url)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.item
    }
}

extension PhotoBrowser: PhotoBrowserCellDelegate {
    func photoBrowserCell(_ cell: PhotoBrowserCell, didSingleTap image: UIImage?) {
        if let delegate = photoBrowserDelegate {
            delegate.photoBrowser(self, willDismissWithIndex: currentIndex, image: image)
        }
        dismiss(animated: true) {
            if let delegate = self.photoBrowserDelegate {
                delegate.photoBrowser(self, didDismissWithIndex: self.currentIndex, image: image)
            }
        }
    }
    
    func photoBrowserCell(_ cell: PhotoBrowserCell, didLongPressWith image: UIImage?) {
        if let delegate = photoBrowserDelegate, let image = image {
            delegate.photoBrowser(self, didLongPressForIndex: currentIndex, image: image)
        }
    }
    
    func photoBrowserCell(_ cell: PhotoBrowserCell, didPanScale scale: CGFloat) {
        let alpha = scale * scale
        if presentationVC != nil {
            presentationVC.bgAlpha = alpha
        }
    }
}

extension PhotoBrowser: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if let cell = collectionView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as? PhotoBrowserCell {
//            print("cell")
////            print(cell.imageView.frame, cell.imageView.image?.size)
//        }
        let animation = PhotoBrowserScaleAnimator()
        animation.isPresented = true
        return animation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = PhotoBrowserScaleAnimator()
        animation.isPresented = false
        return animation
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        presentationVC = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationVC
    }
}

class CustomPresentationController: UIPresentationController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0
        return view
    }()
    
    var bgAlpha: CGFloat {
        set(alpha) {
            backgroundView.alpha = alpha
        }
        get {
            return backgroundView.alpha
        }
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        backgroundView.frame = containerView.bounds
        containerView.insertSubview(backgroundView, at: 0)
        
        //背景动画
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { [weak self] (_) in
                self?.backgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { [weak self](_) in
                self?.backgroundView.alpha = 0
            }, completion: { [weak self](_) in
                self?.backgroundView.alpha = 0
            })
        }
    }
    
}
