//
//  DiscoverTableViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/21.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupVisitorInfo(false, imageName: "visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
    }
}
