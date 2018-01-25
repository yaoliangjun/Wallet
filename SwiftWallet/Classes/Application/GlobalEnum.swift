//
//  GlobalEnum.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/25.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import Foundation

class GlobalEnum: NSObject {

    /// 时间格式
    enum DateFormatter: String {
        case mm = "MM"
        case mmm = "MMM"
        case yyyy = "yyyy"
        case hhmm = "HH:mm"
        case mmdd = "MM/dd"
        case yymm = "yy-MM"
        case yymmdd = "yy-MM-dd"
        case yymmddhhmm = "yy-MM-dd HH:mm"
        case yyyymmdd = "yyyy-MM-dd"
        case yyyymmddhhmm = "yyyy-MM-dd HH:mm"
        case yyyymmddhhmmss = "yyyy-MM-dd HH:mm:ss"
    }
}
