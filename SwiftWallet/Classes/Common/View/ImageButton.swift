//
//  ImageButton.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/5.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  图片按钮

import UIKit

class ImageButton: UIButton {

    var textAlignment: NSTextAlignment?

    convenience init(title: String, titleColor: UIColor, textAlignment: NSTextAlignment?, font: UIFont, image: UIImage?, target: Any?, selector: Selector?) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.setImage(image, for: .normal)
        self.textAlignment = textAlignment

        if let target = target, let selector = selector {
            self.addTarget(target, action: selector, for: .touchUpInside)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if textAlignment == NSTextAlignment.right {
            // 修改图片的Frame
            var imageFrame = self.imageView?.frame
            let imageWidth = self.imageView?.frame.size.width
            imageFrame?.origin.x = self.frame.size.width - imageWidth!
            self.imageView?.frame = imageFrame!

            // 修改Title的Frame
            var titleFrame = self.titleLabel?.frame
            titleFrame!.origin.x = (self.imageView?.frame.origin.x)! - (titleFrame?.size.width)! - 3
            titleFrame!.size = (self.titleLabel?.frame.size)!
            self.titleLabel?.frame = titleFrame!

        } else {
            // 修改图片的Frame
            var imageFrame = self.imageView?.frame
            let titleFrame = self.titleLabel?.frame
            imageFrame?.origin.x = (titleFrame?.origin.x)! + (titleFrame?.size.width)! + 3
            self.imageView?.frame = imageFrame!
        }
    }
}

