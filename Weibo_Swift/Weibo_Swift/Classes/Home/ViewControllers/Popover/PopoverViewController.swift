//
//  PopoverViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/25.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class PopoverPresentViewController: UIPresentationController {
    
    var presentSize = CGSizeZero
    
    /**
     负责实例化被转场的控制器
     
     - parameter presentedViewController:  被展示的视图
     - parameter presentingViewController: 推出被展示视图的视图
     
     - returns: 负责转场的控制器
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    /**
     布局子视图
     */
    override func containerViewWillLayoutSubviews() {
        // 1. 添加遮罩
        containerView?.insertSubview(coverView, atIndex: 0)
        
        // 2. 调整展示视图大小
        if presentSize == CGSizeZero {
            presentedView()?.frame = CGRect(x: (JLKSCREENW - JLKPOPOVERDEFUALTW) * 0.5, y: JLKNAVH - CGFloat(10), width: JLKPOPOVERDEFUALTW, height: JLKPOPOVERDEFUALTH)
        } else {
            presentedView()?.frame = CGRect(x: (JLKSCREENW - presentSize.width) * 0.5, y: JLKNAVH - CGFloat(10), width: presentSize.width, height: presentSize.height)
        }
    }
    
    // MARK: -- 懒加载
    private lazy var coverView: UIView = {
        // 1. 创建遮罩视图
        let view = UIView()
        view.frame = JLKSCREENFRAME
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        
        // 2. 添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    /**
     点击遮罩, 菜单消失方法
     */
    func close() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
