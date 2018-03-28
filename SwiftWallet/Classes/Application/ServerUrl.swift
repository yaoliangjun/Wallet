//
//  ServerUrl.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class ServerUrl: NSObject {

    /** 服务器环境 */
    enum Environment {
        case develop
        case production
    }

    static let environment = Environment.develop

    static func baseUrl() -> String {
        if environment == .develop {
            return "https://mwallet.world-mecoin.com"

        } else {
            return "https://mwallet.world-mecoin.com"
        }
    }

    /** 注册登录 */
    static let login = "/api/login" // 登录
    static let register = "/api/registerWithCaptcha" // 注册
    static let captchaForRegister = "/api/captchaForRegister" // 获取注册短信验证码
    static let findPassword = "/api/resetPasswordForForget" // 忘记密码
    static let captchaForForget = "/api/captchaForForet" // 获取忘记密码验证码
    static let nationals = "/api/nationalCodes" // 获取国家地区区号
    static let logout = "/api/logout" // 退出登录
    static let appVersions = "/api/appVersions" // APP版本检查



    /** =========================================== 设置接口 ============================================== */


    static let changeLoginPwd = "/api/resetPassword" // 重置登录密码
    static let changeTradePwd = "/api/resetTradePassword" // 设置交易密码
    static let captchaForTrade = "/api/captchaForTrade" // 获取设置交易密码验证码


    /** =========================================== 首页接口 ============================================== */

    static let balance = "/api/balance" // 获取钱包余额
    static let walletAddress = "/api/address" // 获取钱包地址

//    #define HOME_MY_WALLET @"/api/myWallet" // 首页钱包信息
//    #define HOME_ALL_COINS @"/api/coins"    // 获取所有有效币种
//    #define HOME_ADD_WALLETS @"/api/coinWallet" // 添加钱包
//    #define HOME_DELETE_WALLET @"/api/disCoinWallet" // 删除钱包


    /** =========================================== 转账接口 ============================================== */

    static let transOut = "/api/transOut"            // 虚拟币转出
    static let transHistories = "/api/histories"     // 交易历史记录
    static let contactList = "/api/queryContacts"    // 获取联系人列表
    static let deleteContact = "/api/deleteContacts" // 删除联系人
    static let updateContact = "/api/updateContacts" // 修改联系人
    static let addContact = "/api/addContacts"       // 新增联系人
}
