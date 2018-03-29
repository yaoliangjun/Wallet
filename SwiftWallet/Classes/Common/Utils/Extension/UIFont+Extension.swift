//
//  UIFont+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/10.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import Foundation

extension UIFont {

    convenience init(_ font: CGFloat) {
        let systemFont = UIFont.systemFont(ofSize: font)
        self.init(name: systemFont.fontName, size: font)!
    }
}
