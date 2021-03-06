//
//  NSDate+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/11/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation

extension NSDate {

    /// 毫秒转成指定格式的时间字符串
    static func dateString(millisecond: String?, _ formatter: String) -> String {
        guard let millis = millisecond else {
            return ""
        }

        let date = Date(timeIntervalSince1970: Double(millis)! / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter

        return dateFormatter.string(from: date)
    }

    /// 秒转成指定格式的时间字符串
    static func dateString(second: String?, _ formatter: String) -> String {
        guard let sec = second else {
            return ""
        }

        let date = Date(timeIntervalSince1970: Double(sec)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter

        return dateFormatter.string(from: date)
    }

    /// 把Date转成指定格式的时间字符串
    static func dateString(date: Date, _ formatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: date)
    }

    /// 把指定格式的时间字符串，转换成毫秒字符串
    static func millisecond(dateString: String, _ formatter: String) -> String {
        if dateString.isEmpty {
            return "0"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        let dateTimeInterval = dateFormatter.date(from: dateString)!.timeIntervalSince1970 * 1000
        return String(format: "%.0f", dateTimeInterval)
    }

    /// 把指定格式的时间字符串，转换成秒字符串
    static func second(dateString: String, _ formatter: String) -> String {
        if dateString.isEmpty {
            return "0"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        let dateTimeInterval = dateFormatter.date(from: dateString)!.timeIntervalSince1970
        return String(format: "%.0f", dateTimeInterval)
    }
}
