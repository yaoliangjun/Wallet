//
//  UILabel+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    /// 创建一个普通的UILabel
    convenience init(text: String?, textColor: UIColor?, font: UIFont?) {
        self.init(text: text, textAlignment: .left, textColor: textColor, font: font)
    }
    
    /// 创建一个普通的UILabel(有对齐方式)
    convenience init(text: String?, textAlignment: NSTextAlignment, textColor: UIColor?, font: UIFont?) {
        self.init(frame: CGRect.zero, text: text, textAlignment: textAlignment, textColor: textColor, font: font)
    }

    /// 创建一个有背景颜色的UILabel
    convenience init(text: String?, textColor: UIColor?, font: UIFont?, backgroundColor: UIColor?) {
        self.init(text: text, textAlignment: .left, textColor: textColor, font: font)
        self.backgroundColor = backgroundColor
    }

    /// 创建一个有Frame的UILabel
    convenience init(frame: CGRect, text: String?, textColor: UIColor?, font: UIFont?) {
        self.init(frame: frame)
        self.text = text
        self.textColor = textColor
        self.font = font
    }

    /// 创建一个有Frame和对齐方式的UILabel
    convenience init(frame: CGRect, text: String?, textAlignment: NSTextAlignment, textColor: UIColor?, font: UIFont?) {
        self.init(frame: frame, text: text, textColor: textColor, font: font)
        self.textAlignment = textAlignment
    }
}
