//
//  BaseModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/26.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: NSObject, HandyJSON {

    var id: String? // 主键

    override required init() {}
}
