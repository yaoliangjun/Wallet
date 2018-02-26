//
//  HomeServices.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/23.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class HomeServices: NSObject {

    /// 获取余额
    static func balance(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: BalanceModel?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.balance, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }

    /// 获取钱包地址
    static func walletAddress(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: AddressModel?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.walletAddress, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }
}
