//
//  PageTestViewCcontroller.swift
//  Demo
//
//  Created by 王云 on 2018/5/7.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class PageTestViewCcontroller: UIPageViewController {
    
    private var pageVC: UIPageViewController!
    
    private var childVCArray: [UIViewController] = [ATestViewController(), BTestViewController(), CTestViewController(), DTestViewController()]
    
    private var currentIndex: Int = 0
    private var pendingVC: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupPageVC()
    }
    
    func setupPageVC() {
        pageVC = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.pageCurl, navigationOrientation: .horizontal, options: nil)
        pageVC.delegate = self
        pageVC.dataSource = self
        
        //设置当前显示的UIViewController
        pageVC.setViewControllers([childVCArray[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.addChildViewController(pageVC)
        pageVC.didMove(toParentViewController: self)
        
        pageVC.view.frame = CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 100)
        view.addSubview(pageVC.view)
    }

}

extension PageTestViewCcontroller: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = currentIndex - 1
        if index < 0 {
            return nil
        }
        return childVCArray[index]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = currentIndex + 1
        if index > childVCArray.count - 1 {
            return nil
        }
        return childVCArray[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingVC = pendingViewControllers.first
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let index = childVCArray.index(of: pendingVC) {
                currentIndex = index
            }
        }
    }
}
