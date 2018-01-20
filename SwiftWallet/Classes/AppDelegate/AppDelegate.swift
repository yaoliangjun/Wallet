//
//  AppDelegate.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/10.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupIQKeyboardManager()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = GlobalConstants.backgroundColor
        window?.makeKeyAndVisible()

//        let hasShowGuidePage = UserDefaults.standard.object(forKey: AppConstants.hasShowGuidePage) as? Bool
//        if let hasShowGuidePage = hasShowGuidePage, hasShowGuidePage {
//            let token = UserDefaults.standard.object(forKey: AppConstants.token) as? String
//            guard let _ = token else {
//                showLoginPage()
//                return true
//            }
//            showMainPage()
//
//        } else {
//            showGuidePage()
//        }

        showLoginPage()

        return true
    }

    // 显示主页面
    func showMainPage() {
        window?.rootViewController = MainTabBarController.sharedMainTabBar()
    }

    // 显示登录页
    func showLoginPage() {
        let navigationController = BaseNavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navigationController
    }

    // 退出登录
    func logout() {
        UserDefaults.standard.set(nil, forKey: AppConstants.token)
        let navigationController = BaseNavigationController(rootViewController: LoginViewController())
        window?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }

    // 显示引导页
    func showGuidePage() {
        window?.rootViewController = GuideViewController()
    }

    // 键盘管理
    fileprivate func setupIQKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 60
    }
}

