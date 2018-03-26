//
//  CommonTextField.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class CommonTextField: UITextField {

    // MARK: - Life Cycle
    // 创建一个默认的CommonTextField
    convenience init(text: String?, placeholder: String?) {
        self.init(text: text, textColor: UIColor.white, placeholder: placeholder, placeholderColor: GlobalConstants.placeholderColor, font: UIFont(15))
    }

    // 创建一个默认的CommonTextField(有rightView, rightViewMode)
    convenience init(text: String?, placeholder: String?, rightView: UIView?, rightViewMode: UITextFieldViewMode?) {
        self.init(text: text, textColor: UIColor.white, placeholder: placeholder, placeholderColor: GlobalConstants.placeholderColor, font: UIFont(15), rightView: rightView, rightViewMode: rightViewMode)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Getter / Setter
    fileprivate func setupSubViews() {
        self.background = UIImage(named: "list_background")
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        self.leftViewMode = .always
    }
}
