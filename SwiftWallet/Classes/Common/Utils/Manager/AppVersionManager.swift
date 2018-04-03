//
//  AppVersionManager.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/28.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import MBProgressHUD

class AppVersionManager: NSObject, UIAlertViewDelegate {

    fileprivate var versionModel: APPVersionModel?
    fileprivate var alertView: MyAlertView?

    static let sharedManager: AppVersionManager = AppVersionManager()

    // 获取APP版本信息
    func fetchAPPVersion(completionHandle: (() -> ())?) {
        let params = ["platform": "ios"]
        LoginServices.appVersionWithParams(params: params, showHUD: true, success: { (response) in
            self.versionModel = response
            let isForceUpdate = response?.force
            let doubleVersion = Double(Bundle.appBuildVersion())
            if (response?.code)! > doubleVersion! {
                // 强制更新
                if isForceUpdate! {
                    self.alertView  = MyAlertView(title: "检测到新版本, 马上更新吧", message: "", delegate: self, cancelButtonTitle: nil)
                    self.alertView?.addButton(withTitle: "确定")
                    self.alertView?.show()

                } else {
                    // 可选更新
                    self.alertView  = MyAlertView(title: "检测到新版本, 是否立即更新?", message: "", delegate: self, cancelButtonTitle: "取消")
                    self.alertView?.addButton(withTitle: "确定")
                    self.alertView?.shouldDismiss = true
                    self.alertView?.show()
                }

            } else {
                if completionHandle != nil {
                    completionHandle!()
                }
            }

        }) { (error) in

        }
    }

    // MARK: - UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.cancelButtonIndex == buttonIndex {
            return
        }

        let updateUrl = versionModel?.url
        if let url = updateUrl {
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
}
