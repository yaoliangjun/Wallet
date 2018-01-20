//
//  DistrictModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/5.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  区号模型

import UIKit
import HandyJSON

class DistrictModel: HandyJSON {

    var id: String?            // 主键
    var abbre: String?         // 国际简称(CN,UK,US)
    var chineseName: String?   // 中文名称
    var code: String?          // 国际代码(86,852)
    var land: String?          // 地区
    var nationalName: String?  // 国际名称
    var price: String?         // 短信价格

    required init() {}
}
