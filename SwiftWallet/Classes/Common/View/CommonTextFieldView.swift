//
//  CommonTextFieldView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class CommonTextFieldView: UIView {

    fileprivate var text: String?
    fileprivate var textColor: UIColor?
    fileprivate var placeHolder: String?
    fileprivate var placeHolderColor: UIColor?
    fileprivate var font: UIFont?
    fileprivate var rightView: UIView?
    fileprivate var rightViewMode: UITextFieldViewMode?
    var textField: UITextField?

    // MARK: - Life Cycle
    /// 创建一个默认的CommonTextFieldView
    convenience init(text: String?, placeholder: String?) {
        self.init()
        self.text = text
        self.textColor = UIColor.white
        self.placeHolder = placeholder
        self.placeHolderColor = GlobalConstants.placeholderColor
        self.font = UIFont(15)
        setupSubViews()
    }

    convenience init(text: String?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.placeHolder = placeholder
        self.placeHolderColor = placeholderColor
        self.font = font
        setupSubViews()
    }

    convenience init(text: String?, textColor: UIColor?, placeholder: String?, placeholderColor: UIColor?, font: UIFont?, rightView: UIView?, rightViewMode: UITextFieldViewMode?) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.placeHolder = placeholder
        self.placeHolderColor = placeholderColor
        self.font = font
        self.rightView = rightView
        self.rightViewMode = rightViewMode
        setupSubViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method
    func textFieldText() -> String? {
        return textField?.text
    }

    func setTextFieldText(_ text: String?) {
        textField?.text = text
    }

    func setSecureTextEntry(_ isSecureTextEntry : Bool) {
        textField?.isSecureTextEntry = isSecureTextEntry
    }

    func setKeyboardType(_ keyboardType: UIKeyboardType) {
        textField?.keyboardType = keyboardType
    }

    // MARK: - Getter / Setter
    fileprivate func setupSubViews() {

        let contentView = UIView()
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        let backgroundImageView = UIImageView(imageName: "list_background")
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }

        textField = UITextField(text: text, textColor: textColor, placeholder: placeHolder, placeholderColor: placeHolderColor, font: font, rightView: rightView, rightViewMode: rightViewMode)
        contentView.addSubview(textField!)
        textField!.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(0, 20, 0, 20))
        }
    }
}
