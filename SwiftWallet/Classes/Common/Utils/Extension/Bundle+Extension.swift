//
//  Bundle+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/28.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import Foundation

extension Bundle {

    /** 获取APP名字 */
    class func appName() -> String {
        var appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String
        if (appName?.isEmpty)! {
            appName = Bundle.main.infoDictionary!["CFBundleName"] as? String
        }
        return appName ?? ""
    }

    /** 获取APP版本号 */
    class func appVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }

    /** 获取APP编译版本号 */
    class func appBuildVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
}
