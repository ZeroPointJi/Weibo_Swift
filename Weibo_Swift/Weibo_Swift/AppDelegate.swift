//
//  AppDelegate.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/21.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 设置全局样式
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        // 1. 创建 Window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // 2. 设置根视图控制器
        window?.rootViewController = MainViewController()
        // 3. 启用 Window
        window?.makeKeyAndVisible()
        
        return true
    }
}