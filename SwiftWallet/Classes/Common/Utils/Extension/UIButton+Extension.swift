//
//  UIButton+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    /// 创建一个基础按钮
    convenience init(frame: CGRect, target: Any?, selector: Selector?) {
        self.init(frame: frame)
        self.addTarget(target, action: selector!, for: .touchUpInside)
    }
    
    /// 创建一个通用的文字按钮
    convenience init(title: String?, titleColor: UIColor, highlightedTitleColor: UIColor?, font: UIFont, target: Any?, selector: Selector?) {
        self.init(frame: CGRect.zero, target: target, selector: selector)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(highlightedTitleColor, for: .highlighted)
        self.titleLabel?.font = font
    }

    /// 创建一个通用的文字按钮
    convenience init(title: String?, titleColor: UIColor, selectedTitleColor: UIColor?, font: UIFont, target: Any?, selector: Selector?) {
        self.init(frame: CGRect.zero, target: target, selector: selector)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(selectedTitleColor, for: .selected)
        self.titleLabel?.font = font
    }

    /// 创建一个文字按钮(有背景图片、按下高亮效果)
    convenience init(title: String?, titleColor: UIColor, highlightedTitleColor: UIColor, font: UIFont, backgroundImage: UIImage?, highlightedBackgroundImage: UIImage?, target: Any?, selector: Selector) {
        self.init(title: title, titleColor: titleColor, highlightedTitleColor: highlightedTitleColor, font: font, target: target, selector: selector)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
    }

    /// 创建一个文字按钮(有背景图片、按下选中效果)
    convenience init(title: String?, titleColor: UIColor, selectedTitleColor: UIColor, font: UIFont, backgroundImage: UIImage?, selectedBackgroundImage: UIImage?, target: Any?, selector: Selector) {
        self.init(title: title, titleColor: titleColor, selectedTitleColor: selectedTitleColor, font: font, target: target, selector: selector)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(selectedBackgroundImage, for: .selected)
    }

    /// 创建一个文字按钮(有背景图片、按下效果、圆角、边框、边框颜色)
    convenience init(title: String?, titleColor: UIColor, highlightedTitleColor: UIColor, font: UIFont, backgroundImage: UIImage?, highlightedBackgroundImage: UIImage?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, target: Any?, selector: Selector) {
        self.init(title: title, titleColor: titleColor, highlightedTitleColor: highlightedTitleColor, font: font, backgroundImage: backgroundImage, highlightedBackgroundImage: highlightedBackgroundImage, target: target, selector: selector)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        self.layer.masksToBounds = true
    }

    /// 创建一个文字按钮(有背景颜色、按下效果、圆角)
    convenience init(title: String?, titleColor: UIColor, highlightedTitleColor: UIColor?, font: UIFont, backgroundColor: UIColor, cornerRadius: CGFloat, target: Any?, selector: Selector) {
        self.init(title: title, titleColor: titleColor, highlightedTitleColor: highlightedTitleColor, font: font, target: target, selector: selector)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }

    /// 创建一个文字按钮(有背景颜色、圆角、边框)
    convenience init(title: String?, titleColor: UIColor, highlightedTitleColor: UIColor, font: UIFont, backgroundColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?, target: Any?, selector: Selector) {
        self.init(title: title, titleColor: titleColor, highlightedTitleColor: highlightedTitleColor, font: font, target: target, selector: selector)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }

    /// 创建一个文字按钮
    convenience init(frame: CGRect, title: String?, titleColor: UIColor, font: UIFont, target: Any?, selector: Selector) {
        self.init(frame: frame)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.addTarget(target, action: selector, for: .touchUpInside)
    }

    /// 创建一个文字按钮(有背景颜色、按下效果、圆角)
    convenience init(frame: CGRect, title: String?, titleColor: UIColor, font: UIFont, backgroundImage: UIImage, highlightedBackgroundImage: UIImage, cornerRadius: CGFloat, target: Any?, selector: Selector) {
        self.init(frame: frame, title: title, titleColor: titleColor, font: font, target: target, selector: selector)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true;
    }

    /// 创建一个文字按钮(有背景颜色、按下效果、圆角、边框)
    convenience init(frame: CGRect, title: String?, titleColor: UIColor, font: UIFont, backgroundImage: UIImage, highlightedBackgroundImage: UIImage, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, target: Any?, selector: Selector) {
        self.init(frame: frame, title: title, titleColor: titleColor, font: font, backgroundImage: backgroundImage, highlightedBackgroundImage: highlightedBackgroundImage, cornerRadius: cornerRadius, target: target, selector: selector)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

    /// 创建一个只有图片的按钮
    convenience init(image: UIImage?, highlightedImage: UIImage?, target: Any?, selector: Selector) {
        self.init()
        self.setImage(image, for: .normal)
        self.setImage(highlightedImage, for: .highlighted)
        self.addTarget(target, action: selector, for: .touchUpInside)
    }

    /// 创建一个图片按钮(有背景颜色)
    convenience init(image: UIImage?, highlightedImage: UIImage?, backgroundColor: UIColor?, target: Any?, selector: Selector) {
        self.init(image: image, highlightedImage: highlightedImage, target: target, selector: selector)
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        }
    }
}
