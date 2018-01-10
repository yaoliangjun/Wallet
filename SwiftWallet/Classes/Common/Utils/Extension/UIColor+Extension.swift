//
//  UIColor+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    /// 十六进制颜色
    convenience init(hexValue: UInt32) {
        let red     = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((hexValue & 0x00FF00) >> 8 ) / 255.0
        let blue    = CGFloat((hexValue & 0x0000FF)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    /// 获取一个随机颜色
    class var random: UIColor {
        get {
            let red   = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue  = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
