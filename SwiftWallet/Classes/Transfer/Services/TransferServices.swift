//
//  TransferServices.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class TransferServices: NSObject {

    static func transOut(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: Dictionary<String, Any>?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.post(url: ServerUrl.transOut, params: params, showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }
}
