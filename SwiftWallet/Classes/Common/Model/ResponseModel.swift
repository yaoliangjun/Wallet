//
//  ResponseModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/12.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import HandyJSON

class ResponseModel<T: HandyJSON>: HandyJSON {

    var content: T?
    var msg: String?
    var code: Int = 0
    var page: Int? = 0
    var pageNum: Int? = 0
    var total: Int? = 0

    required init() {}
}
