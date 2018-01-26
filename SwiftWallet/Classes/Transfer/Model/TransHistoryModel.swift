//
//  TransHistoryModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/26.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  转账记录

import UIKit
//import HandyJSON

class TransHistoryModel: BaseModel {

    var userId: String?          // 用户ID
    var category: Int?           // 交易类型(0-send,1-receive)
    var amount: String = "0"     // 数额
    var nickName: String?        // 联系人昵称
    var address: String?         // 联系人地址
    var createDate: String?      // 交易时间
    var status: String?          // 状态(0-成功，1-失败)
    var remark: String?          // 备注
    var confirmations: String?   // 确认数(确认数>0,表示已到账)
    var coinSymbol: String?      // 币种:ddl

//    override required init() {}
}
