//
//  CommonButton.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/10.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class CommonButton: UIButton {

    /// 创建一个通用按钮
    convenience init(title: String?, target: Any?, selector: Selector) {
        self.init(title: title, titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont(15), backgroundImage: UIImage(named: "confirmation_button_normal"), highlightedBackgroundImage: UIImage(named: "confirmation_button_press"), target: target, selector: selector)
    }

}
