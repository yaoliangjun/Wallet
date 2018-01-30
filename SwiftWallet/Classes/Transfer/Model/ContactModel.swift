//
//  ContactModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/30.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class ContactModel: BaseModel {
    var userId: String?     // 用户ID
    var nickName: String?   // 联系人昵称
    var address: String?    // 联系人钱包地址
    var createTime: String?
    var updateTime: String?
    var coinSymbol: String?
}
