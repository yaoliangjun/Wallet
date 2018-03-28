//
//  APPVersionModel.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/28.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class APPVersionModel: BaseModel {

    /** 序号*/
    var code: Double = 0

    /** 更新内容*/
    var content: String?

    /** 创建时间*/
    var createTime: String?

    /** 主键*/
    var ID: String?

    /** 平台*/
    var platform: String?

    /** 更新时间*/
    var updateTime: String?

    /** 地址*/
    var url: String?

    /** 版本号*/
    var versionName: String?

    /** 强制更新*/
    var force: Bool = false
}
