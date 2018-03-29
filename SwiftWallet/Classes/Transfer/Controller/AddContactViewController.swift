//
//  AddContactViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/2/27.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  添加联系人

import UIKit
import AVFoundation
import MBProgressHUD

class AddContactViewController: BaseViewController, UIAlertViewDelegate {

    var coinSymbol: String?
    fileprivate var addressTextField: UITextField?
    fileprivate var nickNameTextField: CommonTextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        coinSymbol = AppConstants.appCoinSymbol
    }

    // MARK: - Private Method
    @objc fileprivate func confirmBtnClick() {

        let address = addressTextField?.text
        let nickName = nickNameTextField?.text

        if (address?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入对方地址")
            return
        }

        if (nickName?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入对方昵称或手机号")
            return
        }

        view.endEditing(true)

        let params = ["coinSymbol" : coinSymbol ?? "",  "address" : address!,  "nickName" : nickName!]
        TransferServices.addContact(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.show(withStatus: NSLocalizedString("添加成功", comment: ""), completionHandle: {
                self.navigationController?.popViewController(animated: true)
            })

        }) { (error) in

        }
    }

    @objc fileprivate func scanQRCodeBtnClick() {

        view.endEditing(true)

        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || authStatus == .denied {
            let alertView = UIAlertView(title: "提示", message: "请先去 [设置 - 牛盾钱包] 中打开访问开关", delegate: self, cancelButtonTitle: "取消")
            alertView.addButton(withTitle: "确定")
            alertView.show()
            return

        } else {
            let scanVC = ScanViewController()
            scanVC.didScanSuccessClosure = { (result: String?) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    let viewControllers = self.navigationController?.viewControllers
                    for viewController in viewControllers! {
                        if viewController.isKind(of: ScanViewController.self) {
                            self.navigationController?.popViewController(animated: true)
                            break
                        }
                    }
                    self.addressTextField?.text = result
                })

            }
            navigationController?.pushViewController(scanVC, animated: true)
        }
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
            make.width.equalTo(25);
            make.height.equalTo(23);
        }

        nickNameTextField = CommonTextField(text: nil, textColor: UIColor.white, placeholder: NSLocalizedString("请输入对方昵称或手机号", comment: ""), placeholderColor: GlobalConstants.placeholderColor, font: UIFont(15))
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

extension AddContactViewController {

    // MARK: - UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex {
            return
        }

        let url = URL(string: UIApplicationOpenSettingsURLString)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}

