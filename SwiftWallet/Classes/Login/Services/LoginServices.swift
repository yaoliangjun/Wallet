//
//  LoginServices.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  登录注册业务类

import UIKit
import HandyJSON

class LoginServices: NSObject {

    /** 登录 */
    static func login(params: [String: Any], showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.login, params: params, showHUD: showHUD, success: { (response) in
            success(response)
            
        }) { (error) in
            failure(error)
        }
    }

    /** 注册 */
    static func register(params: [String: Any], showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.register, params: params, showHUD: showHUD, success: { (response) in
            success(response)
            
        }) { (error) in
            failure(error)
        }
    }
    
    /** 获取注册验证码 */
    static func verifyCodeForRegister(params: [String: Any], showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.get(url: ServerUrl.captchaForRegister, params: params, showHUD: showHUD, success: { (response) in
            success(response)
            
        }) { (error) in
            failure(error)
        }
    }

    /** 获取找回密码验证码 */
    static func verifyCodeForForget(params: [String: Any], showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.get(url: ServerUrl.captchaForForget, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }

    /** 找回密码 */
    static func findPassword(params: [String: Any], showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.put(url: ServerUrl.findPassword, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }

    /** 获取区号 */
    static func districtNum(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: [DistrictModel]?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.nationals, params: params, showHUD: showHUD, success: { (response: [DistrictModel]?) in
            success(response)

        }) { (error) in

        }
    }
}
