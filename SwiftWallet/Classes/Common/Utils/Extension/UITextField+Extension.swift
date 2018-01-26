//
//  UITextField+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    /// 创建一个通用的UITextField
    convenience init(text: String?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?) {
        self.init(frame: CGRect.zero)
        self.text = text
        self.textColor = textColor
        self.attributedPlaceholder = NSAttributedString.init(string: placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor:placeholderColor ?? UIColor.gray])
        self.font = font
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.clearButtonMode = .whileEditing
    }

    /// 创建一个UITextField(有对齐方式)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?) {
        self.init(text: text, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        if let aligment = textAlignment {
            self.textAlignment = aligment
        }
    }

    /// 创建一个UITextField(有rightView、rightViewMode)
    convenience init(text: String?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, rightView: UIView?, rightViewMode: UITextFieldViewMode?) {
        self.init(text: text, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.rightView = rightView
        if let mode = rightViewMode {
            self.rightViewMode = mode
        }
    }

    /// 创建一个UITextField(有边框、圆角)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }

    /// 创建一个UITextField(有背景颜色、边框、圆角)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, backgroundColor: UIColor?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }

    /// 创建一个UITextField(有leftView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, leftView: UIView?, leftViewMode: UITextFieldViewMode?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.leftView = leftView
        if let mode = leftViewMode {
            self.leftViewMode = mode
        }
    }

    /// 创建一个UITextField(有leftView、rightView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, leftView: UIView?, leftViewMode: UITextFieldViewMode?, rightView: UIView?, rightViewMode: UITextFieldViewMode?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, leftView: leftView, leftViewMode: leftViewMode)
        self.rightView = rightView
        if let mode = rightViewMode {
            self.rightViewMode = mode
        }
    }

    /// 创建一个UITextField(有背景颜色圆角、leftView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, backgroundColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: 0, borderColor: nil, cornerRadius: cornerRadius)
        self.backgroundColor = backgroundColor
        self.leftView = leftView
        self.leftViewMode = .always
    }

    /// 创建一个UITextField(有边框、圆角、leftView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius)
        self.leftView = leftView
        self.leftViewMode = .always
    }

    /// 创建一个UITextField(有边框、圆角、leftView、leftViewMode)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?, leftViewMode: UITextFieldViewMode?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius, leftView: leftView)
        if let mode = leftViewMode {
            self.leftViewMode = mode
        }
    }

    /// 创建一个UITextField(有背景颜色、边框、圆角、leftView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, backgroundColor: UIColor?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius)
        self.leftView = leftView
        self.leftViewMode = .always
    }

    /// 创建一个UITextField(有背景颜色、边框、圆角、leftView、leftViewMode)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, backgroundColor: UIColor?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?, leftViewMode: UITextFieldViewMode?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius)
        self.leftView = leftView
        if let mode = leftViewMode {
            self.leftViewMode = mode
        }
    }

    /// 创建一个UITextField(有背景颜色、边框、圆角、leftView、rightView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, backgroundColor: UIColor?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?, rightView: UIView?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius, leftView: leftView, rightView: rightView)
        self.backgroundColor = backgroundColor
    }

    /// 创建一个UITextField(有边框、圆角、rightView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, rightView: UIView?, rightViewMode: UITextFieldViewMode?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius)
        self.rightView = rightView
        if let mode = rightViewMode {
            self.rightViewMode = mode
        }
    }

    /// 创建一个UITextField(有边框、圆角、leftView、rightView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?, rightView: UIView?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius, leftView: leftView, leftViewMode: .always)
        self.rightView = rightView
        self.rightViewMode = .always
    }

    /// 创建一个UITextField(有边框、圆角、leftView、leftViewMode和rightView、rightViewMode)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView?, leftViewMode: UITextFieldViewMode?, rightView: UIView?, rightViewMode: UITextFieldViewMode?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius, leftView: leftView, rightView: rightView)
        if let mode = leftViewMode {
            self.leftViewMode = mode
        }

        if let mode = rightViewMode {
            self.rightViewMode = mode
        }
    }

    /// 创建一个UITextField(有Frame、leftView)
    convenience init(frame: CGRect, text: String?, textAlignment: NSTextAlignment?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, leftView: UIView?) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.frame = frame
        self.leftView = leftView
        self.leftViewMode = .always
    }
}
