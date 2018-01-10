//
//  BaseNavigationController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarAppearance()
    }

    func setupNavigationBarAppearance() {
        // 设置导航栏背景图片和文字颜色大小
        let navigationBar = UINavigationBar.appearance()
        navigationBar.setBackgroundImage(UIImage.createImage(color: GlobalConstants.navigationBarColor), for: .default)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: AppConstants.goldColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
        
        // 设置返回键的颜色和隐藏返回文字
        navigationBar.tintColor = AppConstants.goldColor
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for: .default)
        
        // 白色状态栏
        let application = UIApplication.shared
        application.setStatusBarStyle(.lightContent, animated: true)
        application.setStatusBarHidden(false, with: .none)
    }

    // PUSH的时候隐藏TabBar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    func backArrowClick() {
        
    }
}
