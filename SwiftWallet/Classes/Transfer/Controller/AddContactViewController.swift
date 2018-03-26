//
//  AddContactViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/2/27.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  添加联系人

import UIKit

class AddContactViewController: BaseViewController {

    fileprivate var addressTextField: UITextField?
    fileprivate var nickNameTextField: CommonTextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Private Method
    @objc fileprivate func confirmBtnClick() {

    }

    @objc fileprivate func scanQRCodeBtnClick() {

    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = NSLocalizedString("添加联系人", comment: "")

        let contentView = UIView()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(50)
        }

        let backgroundImageView = CommonView()
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }

        // 地址
        addressTextField = UITextField(text: nil, textColor: UIColor.white, placeholder: NSLocalizedString("请输入转至交易所地址或扫码", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(14))
        contentView.addSubview(addressTextField!)
        addressTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.top.bottom.equalTo(contentView)
        }

        // 扫码
        let scanQRCodeBtn = UIButton(image: UIImage(named: "sweep_code_normal"), highlightedImage: UIImage(named: "sweep_code_press"), target: self, selector: #selector(scanQRCodeBtnClick))
        contentView.addSubview(scanQRCodeBtn)
        scanQRCodeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-20);
            make.left.equalTo(addressTextField!.snp.right).offset(10);
            make.centerY.equalTo(contentView);
            make.width.equalTo(20);
            make.height.equalTo(18);
        }

        nickNameTextField = CommonTextField(text: nil, textColor: AppConstants.goldColor, placeholder: NSLocalizedString("请输入对方昵称或手机号", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(15))
        view.addSubview(nickNameTextField!)
        nickNameTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom).offset(15)
            make.left.right.height.equalTo(contentView)
        }

        let confirmBtn = CommonButton(title: NSLocalizedString("确定", comment: ""), target: self, selector: #selector(confirmBtnClick))
        view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50);
            make.left.equalTo(view).offset(30);
            make.right.equalTo(view).offset(-30);
            make.top.equalTo(nickNameTextField!.snp.bottom).offset(60);
        }
    }
}
