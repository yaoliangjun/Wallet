//
//  UserInfoManager.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {

    /** 是否设置了交易密码 */
    static func hasTradePassword() -> Bool {
        return UserDefaults.standard.bool(forKey: AppConstants.hasTradePassword)
    }

    /** 设置交易密码 */
    static func saveHasTradePassword(_ hasTradePassword: Bool?) {
        UserDefaults.standard.setValue(hasTradePassword, forKey: AppConstants.hasTradePassword)
        UserDefaults.standard.synchronize()
    }

    /** 获取token */
    static func token() -> String? {
        return UserDefaults.standard.object(forKey: AppConstants.token) as? String
    }

    /** 设置token */
    static func saveToken(_ token: String?) {
        UserDefaults.standard.setValue(token, forKey: AppConstants.token)
        UserDefaults.standard.synchronize()
    }

    /** 获取登录账号 */
    static func account() -> String? {
        return UserDefaults.standard.object(forKey: AppConstants.account) as? String
    }

    /** 设置登录账号 */
    static func saveAccount(_ account: String?) {
        UserDefaults.standard.setValue(account, forKey: AppConstants.account)
        UserDefaults.standard.synchronize()
    }
}
