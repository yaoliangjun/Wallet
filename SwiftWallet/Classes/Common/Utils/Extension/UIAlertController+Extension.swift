//
//  UIAlertController+Extension.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/12/27.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation

extension UIAlertController {

    /// UIAlertController: 有确定、取消两个按钮
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, positiveActionTitle: String, positiveCompletionHandle: @escaping (_ alert: UIAlertController) -> (), negativeActionTitle: String, negativeCompletionHandle: ((_ alert: UIAlertController) -> ())?) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)

        let positiveAction = UIAlertAction(title: positiveActionTitle, style: .default) { (action) in
            positiveCompletionHandle(self)
        }
        self.addAction(positiveAction)

        let negativeAction = UIAlertAction(title: negativeActionTitle, style: .cancel) { (action) in
            if negativeCompletionHandle != nil {
                negativeCompletionHandle!(self)
            }
        }
        self.addAction(negativeAction)
    }

    /// UIAlertController: 只有一个按钮
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, actionTitle: String, completionHandle: @escaping (_ alert: UIAlertController) -> ()) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)

        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            completionHandle(self)
        }
        self.addAction(action)
    }
}
