//
//  MineServices.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/26.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class MineServices: NSObject {

    /** 修改登录密码 */
    static func changeLoginPassword(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.put(url: ServerUrl.changeLoginPwd, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }

    /** 设置和修改交易密码 */
    static func changeTradePassword(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.put(url: ServerUrl.changeTradePwd, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }

    /** 获取修改交易密码的验证码 */
    static func tradeVericodeWithParams(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.captchaForTrade, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }
}
