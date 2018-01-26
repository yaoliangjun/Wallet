//
//  BalanceModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/23.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  余额模型

import UIKit
import HandyJSON

class BalanceModel: HandyJSON {

    required init() {}

    var balance: String = "0" // 余额
    var freezed: String = "0" // 冻结金额
    var useable: String = "0" // 可用金额
    var rate: String?
}
