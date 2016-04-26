//
//  ProfileTableViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/21.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupVisitorInfo(false, imageName: "visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }
}
