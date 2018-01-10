//
//  UIImageView+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/12/25.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation

extension UIImageView {

    /// 创建一个UIImageView(有Frame、图片名字)
    convenience init(frame: CGRect, imageName: String) {
        self.init(frame: frame)
        self.image = UIImage(named: imageName)
    }
}
