//
//  VisitorView.swift
//  Weibo_Swift
//
//  Created by zero on 16/4/22.
//  Copyright © 2016年 zero. All rights reserved.
//

import UIKit

// 定义协议用于登录注册点击方法的回调
protocol VisitorViewDelegate: NSObjectProtocol {
    /// 登录回调
    func loginBtnWillClick()
    /// 注册回调
    func registerBtnWillClick()
}

class VisitorView: UIView {
    
    weak var delegate: VisitorViewDelegate?
    
    /**
     初始化VisitorView
     
     - parameter isHome:    是否是首页
     - parameter imageName: 中间图片名称
     - parameter message:   文本内容
     */
    func setupVisitorInfo(isHome: Bool, imageName: String, message: String) {
        // 设置背景图片是否显示
        iconImageView.hidden = !isHome
        
        // 设置中间图片
        homeImageView.image  = UIImage(named: imageName)
        
        // 设置文本内容
        messageLabel.text = message
        
        if isHome {
            startAnimation()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        // 1. 添加控件
        addSubview(iconImageView)
        addSubview(maskImageView)
        addSubview(homeImageView)
        addSubview(messageLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        
        // 2. 布局控件
        // 2.1 布局背景图片
        iconImageView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        // 2.2 布局遮罩
        maskImageView.xmg_Fill(self, insets: UIEdgeInsetsMake(0, 0, 50, 0))
        // 2.3 布局房子图片
        homeImageView.xmg_AlignInner(type: .Center, referView: iconImageView, size: nil)
        // 2.4 布局信息文本
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconImageView, size: nil)
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224)) // "哪个控件" 的 "什么属性" "等于" "另一个控件" 的 "什么属性" 乘以 "多少" 加上 "多少"
        // 2.5 布局登录按钮
        loginButton.xmg_AlignVertical(type: XMG_AlignType.BottomRight, referView: messageLabel, size: CGSizeMake(100, 30), offset: CGPointMake(0, 10))
        // 2.6 布局注册按钮
        registerButton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSizeMake(100, 30), offset: CGPointMake(0, 10))
        
    }
    
    /**
        设置图片滚动
     */
    private func startAnimation() {
        // 1. 创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 20
        animation.repeatCount = MAXFLOAT
        // 1.1 设置动画不在完成后移除
        animation.removedOnCompletion = false
        
        // 2. 给图片设置动画
        iconImageView.layer.addAnimation(animation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        登录点击事件
     */
    func loginBtnClick() {
        delegate?.loginBtnWillClick()
    }
    
    /**
        注册点击事件
     */
    func registerBtnClick() {
        delegate?.registerBtnWillClick()
    }
    
    // MARK: -- 懒加载
    
    /// 背景图片
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return imageView
    }()
    
    /// 遮罩图片
    private lazy var maskImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return imageView
    }()
    
    /// 房子图片
    private lazy var homeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return imageView
    }()
    
    /// 信息文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "asdfasdfasdfasdfas;ldfkjsaldkfja;slkdfja;sldkfja;s"
        label.textColor = UIColor.darkGrayColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        return label
    }()
    
    /// 登陆按钮
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登陆", forState: .Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        button.addTarget(self, action: #selector(loginBtnClick), forControlEvents: .TouchUpInside)
        return button
    }()
    
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("注册", forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        button.addTarget(self, action: #selector(registerBtnClick), forControlEvents: .TouchUpInside)
        return button
    }()
}