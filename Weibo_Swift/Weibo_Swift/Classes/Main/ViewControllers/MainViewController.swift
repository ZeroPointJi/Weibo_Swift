//
//  MainViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/21.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK: -- 数据加载
    private lazy var composeBtn: UIButton = {
        // 1. 创建按钮
        let btn = UIButton()
        
        // 2. 设置按钮的 frame
        let width = UIScreen.mainScreen().bounds.size.width / CGFloat(self.viewControllers!.count)
        let rect = CGRectMake(0, 0, width, 50)
        btn.frame = rect
        
        // 3. 设置按钮 framea 偏移
        btn.frame = CGRectOffset(rect, width * 2, 0)
        
        return btn
    }()

    // MARK: -- 重写方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加所有子控制器
        addChildViewControllers()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 添加按钮到屏幕中
        setupComposeBtn()
    }
    
    // MARK: -- 视图相关
    /**
        设置按钮属性
     */
    private func setupComposeBtn() {
        tabBar.addSubview(composeBtn)
        
        // 设置按钮前景图片
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        // 设置按钮背景图片
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        // 添加点击事件
        composeBtn.addTarget(self, action: #selector(composeBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /**
        按钮点击方法
     */
    func composeBtnClick() {
        print(#function)
    }
    
    /**
        添加所有子控制器
     */
    private func addChildViewControllers() {
        // 1. 获取 json 地址
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        
        // 2. 得到 json 文件, 为 NSdata 类型
        if let jsonData = NSData(contentsOfFile: path!) {
            do {
                // 3. 转换为数组
                let dataArr = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                // 4. 遍历数组获取数据创建视图控制器
                for data in dataArr as! [[String: String]] {
                    addChildViewController(data["vcName"]!, title: data["title"]!, imageName: data["imageName"]!)
                }
            } catch {
                // 如果获取 json 数据错误, 从本地创建
                print(error)
                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                
                // 添加一个空控制器用来占位
                addChildViewController("NullViewController", title: "", imageName: "")
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            }
        }
    }
    
    /**
     创建视图控制器
     
     - parameter childControllerName: 需要初始化的子视图控制器名称
     - parameter title:           子视图控制器标题
     - parameter imageName:       子视图控制器图片名称
     */
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        
        // 1. 获取命名空间
        let ns: String = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        // 2. 拼接字符串为类名
        let clsName = ns + "." + childControllerName
        
        // 3. 将字符串转换为类
        let cls: AnyClass? = NSClassFromString(clsName)
        
        // 4. 将类转换为视图控制器类
        let vcCls = cls as! UIViewController.Type
        
        // 5. 创建视图控制器
        let vc = vcCls.init()
        
        // 6 设置控制器对应数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)_highlighted")
        vc.title = title
        
        // 7. 包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        // 8. 将导航控制器添加到当前控制器
        addChildViewController(nav)
    }
}