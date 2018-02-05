//
//  CustomPresentViewController.swift
//  Demo
//
//  Created by 王云 on 2018/1/29.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class CustomPresentViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {
    
    var tapToDismiss = true
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    fileprivate func config() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tapToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
            tap.delegate = self
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func onTap() {
        if tapToDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view {
            return true
        }
        return false
    }
}

class PresentedController: UIPresentationController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.alpha = 0
        return view
    }()
  
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {return}
        
        //添加背景图
        backgroundView.frame = containerView.bounds
        print(backgroundView.frame)
        containerView.insertSubview(backgroundView, at: 0)
        
        //背景动画
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: {[weak self] (UIViewControllerTransitionCoordinatorContext) -> Void in
                self?.backgroundView.alpha = 1
                }, completion: nil)
        }else {
            UIView.animate(withDuration: 0, animations: {[weak self] () -> Void in
                self?.backgroundView.alpha = 1
            })
        }
    }
    
    override func dismissalTransitionWillBegin() {
        
        //背景动画
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: {[weak self] (UIViewControllerTransitionCoordinatorContext) -> Void in
                self?.backgroundView.alpha = 0
                }, completion: nil)
        }else {
            UIView.animate(withDuration: 0, animations: {[weak self] () -> Void in
                self?.backgroundView.alpha = 0
            })
        }
    }
}

//MARK:- 底部进入样式
class CustomPresentBottomInController: CustomPresentViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = ViewControllerAnimatedTransitioningMove()
        animationController.isPresented = true
        return animationController
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = ViewControllerAnimatedTransitioningMove()
        animationController.isPresented = false
        return animationController
        
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentedController(presentedViewController: presented, presenting: presenting)
    }
}

//MARK:- Scale样式
class CustomPresentScaleController: CustomPresentViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = ViewControllerAnimatedTransitioningScale()
        animationController.isPresented = true
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = ViewControllerAnimatedTransitioningScale()
        animationController.isPresented = false
        return animationController
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentedController(presentedViewController: presented, presenting: presenting)
    }
}

class CustomPresentSpreadViewController: CustomPresentViewController {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animatedTransitioning = ViewControllerAnimatedTransitioningSpread()
        animatedTransitioning.isPresented = true
        return animatedTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animatedTransitioning = ViewControllerAnimatedTransitioningSpread()
        animatedTransitioning.isPresented = false
        return animatedTransitioning
    }
    
}

