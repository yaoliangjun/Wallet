//
//  BaseViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var placeholderView: PlaceholderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseViewController()
        setupSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /// 子类重写该方法设置视图
    func setupSubViews() {

    }

    /// 设置基类控制器
    private func setupBaseViewController() {
        view.backgroundColor = GlobalConstants.backgroundColor

        let count: Int? = navigationController?.viewControllers.count
        if count != nil && count! > 1 {
            // 设置导航栏返回按钮图片
            navigationItem.leftBarButtonItem = UIBarButtonItem(arrowImageName: "return_button_normal", target: self, selector: #selector(popViewController))
        }
    }

    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
