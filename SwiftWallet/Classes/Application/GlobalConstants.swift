//
//  GlobalConstants.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  全局常量

import UIKit

class GlobalConstants: NSObject {

    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let navigationBarHeight: CGFloat = 64
    static let tabBarHeight: CGFloat = 49
    static let tableViewHeight: CGFloat = screenHeight - navigationBarHeight
    
    // 颜色
    static let navigationBarColor = UIColor(hexValue: 0x222126) // 导航栏背景颜色
    static let tabBarColor = navigationBarColor // TabBar背景颜色
    static let lineColor = UIColor(hexValue: 0xCCCCCC) // 分割线颜色
    static let backgroundColor = UIColor(hexValue: 0x1A191A)  // 页面背景颜色
    static let placeholderColor = UIColor(hexValue: 0xCCCCCC)
}
