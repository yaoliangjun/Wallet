//
//  BaseTabBarController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }

    func setupTabBarAppearance() {
        // 设置背景颜色
        tabBar.barTintColor = GlobalConstants.tabBarColor
        tabBar.isTranslucent = false // 去掉半透明效果
        tabBar.backgroundImage =  UIImage.createImage(color: GlobalConstants.backgroundColor)
        tabBar.shadowImage = UIImage()

        // 设置字体和颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: GlobalConstants.placeholderColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppConstants.goldColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)], for: .selected)
    }
}
