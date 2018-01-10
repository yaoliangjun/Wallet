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
            return "http://47.52.72.135/newton/dev/api"

        } else {
            return "http://47.52.142.113:9070"
        }
    }
    

    /** 注册登录 */
    static let login = "/user/login" // 登录
    static let register = "/user/register" // 注册
    static let verifyCode = "/user/veri-code" // 获取短信验证码
    static let findPassword = "/user/forget-pwd" // 忘记登陆密码
    static let nationals = "/finance/qianbao/nationals" // 获取国家地区区号


    /** 首页 */
    static let marketSummary = "/market/summary" // 获取当前各币种行情
    static let messageList = "/amount/notice" // 获取消息列表


    /** 交易 */
    static let cancelOrderList = "/trade" // 撤单列表
    static let cancelOrder = "/trade/cancel/%@" // 撤单
    static let balances = "/finance/coin/getBalances" // 获取买入对应市场的可用余额
    static let marketQuote = "/market/quote/symbol/%@?tradeType=ALL" // 获取某个币种最新的买单和卖单
    static let trade = "/trade" // 买入、卖出
    
    /** 资讯 */
    static let infoList = "/info/list" // 获取资讯


    /** 账户 */
    static let myAssets = "/finance/coin/myAssets" //我的资产
}
