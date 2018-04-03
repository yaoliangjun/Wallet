//
//  BaseViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController, UIViewControllerRestoration {

    var placeholderView: PlaceholderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseViewController()
        setupSubViews()

        restorationIdentifier = String(describing: type(of: self))

        /*
         The class specified here must conform to `UIViewControllerRestoration`,
         explained above. If not set, you'd get a second chance to create the
         view controller on demand in the app delegate.
         */
        restorationClass = type(of: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MBProgressHUD.dismiss()
    }

    // MARK: - UIViewControllerRestoration
    static func viewController(withRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        let vc = self.init(coder: coder)
        return vc
    }

    /// 子类重写该方法设置视图
    func setupSubViews() {

    }

    /// 设置基类控制器
    private func setupBaseViewController() {
        view.backgroundColor = GlobalConstants.backgroundColor

        // 兼容APP状态保存功能
        if !self.isKind(of: HomeViewController.self) &&
           !self.isKind(of: TransferViewController.self) &&
           !self.isKind(of: MineViewController.self) &&
           !self.isKind(of: LoginViewController.self) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(arrowImageName: "return_button_normal", target: self, selector: #selector(popViewController))

            // 隐藏Tabbar
            hidesBottomBarWhenPushed = true
        }

//        let count: Int? = navigationController?.viewControllers.count
//        if count != nil && count! > 1 {
//            // 设置导航栏返回按钮图片
//            navigationItem.leftBarButtonItem = UIBarButtonItem(arrowImageName: "return_button_normal", target: self, selector: #selector(popViewController))
//        }
    }

    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    deinit {
        Logger("##### \(self) deinit #####")
    }
}
