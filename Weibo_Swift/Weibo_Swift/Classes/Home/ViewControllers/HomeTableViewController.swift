//
//  HomeTableViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/21.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 初始化未登录界面
        if !isLogin {
            visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 2. 设置导航栏
        setupNav()
        
        // 3. 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(titleBtnChange), name: JLKPopoverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(titleBtnChange), name: JLKPopoverAnimatorWillDismiss, object: nil)
    }
    
    /**
     按钮状态改变
     */
    func titleBtnChange() {
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.selected = !titleBtn.selected
    }
    
    /**
     设置导航栏
     */
    private func setupNav() {
        // 1. 初始化左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonWithButton(imageName: "navigationbar_friendattention", target: self, action: #selector(leftItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonWithButton(imageName: "navigationbar_pop", target: self, action: #selector(rightItemClick))
        
        // 2. 初始化标题
        let titleBtn = TitleButton()
        titleBtn.setTitle("Zero's space ", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    /**
     标题按钮点击事件
     */
    func titleBtnClick(btn: TitleButton) {
        // 1. 弹出视图
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        
        // 2.1 设置弹出视图代理
        vc?.transitioningDelegate = popoverAnimator
        
        // 2.2 设置弹出视图样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        self.presentViewController(vc!, animated: true, completion: nil)
    }
    
    /**
     左按钮点击事件
     */
    func leftItemClick() {
        print(#function)
    }
    
    /**
     右按钮点击事件
     */
    func rightItemClick() {
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let QRCodeVC = sb.instantiateInitialViewController()
        presentViewController(QRCodeVC!, animated: true, completion: nil)
    }
    
    private lazy var popoverAnimator: PopoverAnimator = {
       let po = PopoverAnimator()
       // 设置弹出视图的大小
       po.presentSize = CGSizeMake(200, 200)
        
       return po
    }()
}