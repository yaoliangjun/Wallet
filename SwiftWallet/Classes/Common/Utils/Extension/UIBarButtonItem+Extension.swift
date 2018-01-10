//
//  UIBarButtonItem+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/11/28.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation

extension UIBarButtonItem {

    /// 创建一个导航栏按钮（返回箭头）
    convenience init(arrowImageName: String, target: Any?, selector: Selector) {

        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        if !arrowImageName.isEmpty {
            let arrowImageView = UIImageView(image: UIImage(named: arrowImageName))
            arrowImageView.frame = CGRect(x: 0, y: 10, width: 11, height: 20)
            btn.addSubview(arrowImageView)
        }
        btn.addTarget(target, action: selector, for: .touchUpInside)

        self.init(customView: btn)
    }

    /// 创建一个自定义的导航栏按钮（文字）
    convenience init(title: String, titleColor: UIColor?, font: UIFont, target: Any?, selector: Selector) {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = font
        btn.addTarget(target, action: selector, for: .touchUpInside)

        self.init(customView: btn)
    }

    /// 创建一个自定义的导航栏按钮（图片）
    convenience init(imageName: String, target: Any?, selector: Selector) {
        self.init(image: UIImage(named: imageName), style: .done, target: target, action: selector)
    }
}

