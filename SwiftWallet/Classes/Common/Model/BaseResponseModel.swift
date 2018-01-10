//
//  BaseResponseModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseResponseModel: NSObject {

    var content: Any? = nil
    var errorMessage: String? = nil
    var statusCode: Int = 0
    var page: Int? = 0
    var pageNum: Int? = 0
    var total: Int? = 0
}
