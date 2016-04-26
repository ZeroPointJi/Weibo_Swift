//
//  UIBarButtonItem+CreateBarButtonWithButton.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/25.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createBarButtonWithButton(imageName imageName: String, target: AnyObject?, action: Selector) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName) , forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
}