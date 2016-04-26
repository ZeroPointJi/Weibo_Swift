//
//  QRCodeViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/25.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
        /// 视图宽度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
        /// 冲击波顶部约束
    @IBOutlet weak var scanlineTopCons: NSLayoutConstraint!
        /// 冲击波视图
    @IBOutlet weak var scanlineView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 设置初始选中二维码
        tabBar.selectedItem = tabBar.items![0]
        
        // 2. 设置监听
        tabBar.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimation()
    }
    
    /**
     开始执行动画
     */
    private func startAnimation() {
        // 初始化视图位置
        scanlineTopCons.constant = -containerHeightCons.constant
        // 必须刷新本控制器视图
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(2.0, animations: {
            // 1. 设置动画循环次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            // 2. 修改约束
            self.scanlineTopCons.constant = self.containerHeightCons.constant
            // 3. 设置强制刷新
            // 必须刷新本控制器视图
            self.view.layoutIfNeeded()
            })
    }
    
    @IBAction func CloseClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func photoAlbumClick(sender: AnyObject) {
        
    }
    
}

extension QRCodeViewController: UITabBarDelegate {
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        // 1. 修改约束
        containerHeightCons.constant = item.tag == 1 ? 300 : 300 * 0.5
        
        // 2. 移除所有动画
        scanlineView.layer.removeAllAnimations()
        
        // 3. 重新开始动画
        startAnimation()
    }
}