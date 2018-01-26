//
//  TransferServices.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  转账业务类

import UIKit

class TransferServices: NSObject {

    /** 转至交易所 */
    static func transOut(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.post(url: ServerUrl.transOut, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }

    /** 获取转账记录 */
    static func transHistories(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: [TransHistoryModel]?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.transHistories, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }
}
