//
//  MyAlertView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/28.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class MyAlertView: UIAlertView {

    var shouldDismiss: Bool = false

    override func dismiss(withClickedButtonIndex buttonIndex: Int, animated: Bool) {
        if shouldDismiss {
            super.dismiss(withClickedButtonIndex: buttonIndex, animated: animated)
        }
    }
}
