//
//  PopoverAnimator.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/25.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

let JLKPopoverAnimatorWillShow = "JLKPopoverAnimatorWillShow"
let JLKPopoverAnimatorWillDismiss = "JLKPopoverAnimatorWillDismiss"

class PopoverAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    
    var presentSize = CGSizeZero
    
    // 返回负责转场的控制器对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let popoverVC = PopoverPresentViewController(presentedViewController: presented, presentingViewController: presenting)
        popoverVC.presentSize = presentSize
        return popoverVC
    }
    
    // 只要使用了一下方法, 动画所需的所有特效以及参数都需要程序员自己设定
    /**
     指定展现动画的控制器
     
     - parameter presented:  被展示的控制器
     - parameter presenting: 推出控制器的控制器
     
     - returns: 指定转场控制器
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 当展现动画要开始执行的时候,发送通知
        NSNotificationCenter.defaultCenter().postNotificationName(JLKPopoverAnimatorWillShow, object: self)
        return self
    }
    
    /**
     指定消失动画的控制器
     
     - parameter dismissed: 被消失的控制器
     
     - returns: 指定转场控制器
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 当消失动画要开始执行的时候,发送通知
        NSNotificationCenter.defaultCenter().postNotificationName(JLKPopoverAnimatorWillDismiss, object: self)
        return self
    }
    
    // MARK: -- UIViewControllerAnimatedTransitioning
    /**
     转场动画执行时间
     
     - parameter transitionContext: 上下文, 其中有转场的所有参数
     
     - returns: 执行时间
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    /**
     每次转场动画执行时都会调用的方法
     
     - parameter transitionContext: 上下文, 其中有转场的所有参数
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 如果目标视图存在, 则为显示动画, 否则为消失动画
        if let toView = transitionContext.viewForKey(UITransitionContextToViewKey) {
            // 1. 添加被展示视图到容器视图中
            transitionContext.containerView()?.addSubview(toView)
            
            // 2. 设置被展示视图
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            toView.layer.anchorPoint = CGPointMake(0.5, 0.0) // 设置锚点, 否则动画从中间展开
            
            // 3. 执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                // 动画执行语句
                toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: { (_) in
                    // 必须告诉系统, 动画执行完毕, 否则会出现位未知错误
                    transitionContext.completeTransition(true)
            })
        } else {
            // 1. 获取要消失的视图
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            // 2. 执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                // 动画执行中, 要改变的值绝对不能为0, 否则视图直接消失.
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.0000001)
                }, completion: { (_) in
                    // 必须告诉系统, 动画执行完毕, 否则会出现位未知错误
                    transitionContext.completeTransition(true)
                    // 视图从父视图移除
                    fromView?.removeFromSuperview()
            })
        }
    }
}