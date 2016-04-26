//
//  BaseTableViewController.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/22.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var isLogin = true
    var visitorView: VisitorView?
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitor()
    }

    /**
        加载未登陆界面
     */
    private func setupVisitor() {
        visitorView = VisitorView()
        visitorView!.delegate = self
        view = visitorView
    }
}

extension BaseTableViewController: VisitorViewDelegate {
    // 注册
    func registerBtnWillClick() {
        print(#function)
    }
    // 登录
    func loginBtnWillClick() {
        print(#function)
    }
}