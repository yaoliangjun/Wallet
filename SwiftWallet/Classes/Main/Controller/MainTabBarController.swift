//
//  MainTabBarController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/10.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  主界面

import UIKit

class MainTabBarController: BaseTabBarController {

    // 单例
    static let mainTabBarController = MainTabBarController()
    static func sharedMainTabBar() -> MainTabBarController {
        return mainTabBarController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    // 设置主控制器
    func setupViewController() {
        let homeVC = HomeViewController()
        addChildViewController(childController: homeVC, title: NSLocalizedString("首页", comment: ""), image: "home_home_normal", selectedImage: "home_home_press")

        let transferVC = TransferViewController()
        addChildViewController(childController: transferVC, title: NSLocalizedString("交易", comment: ""), image: "home_transfer_normal", selectedImage: "home_transfer_press")

        let mineVC = MineViewController()
        addChildViewController(childController: mineVC, title: NSLocalizedString("我的", comment: ""), image: "home_mine_normal", selectedImage: "home_mine_press")
    }

    // 添加子控制器
    func addChildViewController(childController: UIViewController, title: String, image: String, selectedImage: String) {
        childController.title = title;
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        let baseNavigationController = BaseNavigationController(rootViewController: childController)
        addChildViewController(baseNavigationController)
    }
}

