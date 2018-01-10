//
//  CommonUtils.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/12/5.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  通用工具类

import UIKit

class CommonUtils: NSObject {

    /** 获取系统语言 */
    static func defaultLanguage() -> String {
        let userDefaults = UserDefaults.standard
        let allLanguages = userDefaults.object(forKey: "AppleLanguages") as! Array<String>
        return allLanguages.first!
    }
}
