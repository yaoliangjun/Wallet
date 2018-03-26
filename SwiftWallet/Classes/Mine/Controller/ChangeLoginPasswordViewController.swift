//
//  ChangeLoginPasswordViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/3/20.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit
import MBProgressHUD

class ChangeLoginPasswordViewController: BaseViewController, UITextFieldDelegate {

    fileprivate var previousPwdTextField: CommonTextField?
    fileprivate var pwdTextField: CommonTextField?
    fileprivate var repeatPwdTextField: CommonTextField?
    fileprivate var showPreviousPassword: Bool = false
    fileprivate var showPassword: Bool = false
    fileprivate var showRepeatPassword: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // 明文切换密文后避免被清空
        var toBeStr = textField.text
        let rag = toBeStr?.toRange(range)
        toBeStr = toBeStr?.replacingCharacters(in: rag!, with: string)

        if textField == previousPwdTextField &&  textField.isSecureTextEntry {
            textField.text = toBeStr
            return false

        } else if textField == pwdTextField &&  textField.isSecureTextEntry {
            textField.text = toBeStr
            return false

        }else if textField == repeatPwdTextField &&  textField.isSecureTextEntry {
            textField.text = toBeStr
            return false
        }

        return true
    }

    // MARK: - Private Method
    @objc fileprivate func resetPasswordBtnClick() {
        let previousPwd = previousPwdTextField?.text
        let password = pwdTextField?.text
        let repeatPassword = repeatPwdTextField?.text

        if (previousPwd?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入旧登录密码", comment: ""))
            return
        }

        if (password?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入新密码", comment: ""))
            return
        }

        if !(password?.validPasswordFormatter())! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入6-16位字符与数字的登录密码", comment: ""))
            return
        }

        if (repeatPassword?.isEmpty)! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请再次输入新密码Hint", comment: ""))
            return
        }

        if !(repeatPassword?.validPasswordFormatter())! {
            MBProgressHUD.show(withStatus: NSLocalizedString("请输入6-16位字符与数字的登录密码", comment: ""))
            return
        }

        if password != repeatPassword {
            MBProgressHUD.show(withStatus: NSLocalizedString("两次输入的密码不一致", comment: ""))
            return
        }

        view.endEditing(true)

        let params = ["password": previousPwd?.md5() ?? "", "newPassword": password?.md5() ?? ""]
        MineServices.changeLoginPassword(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.showShort(withStatus: NSLocalizedString("修改成功", comment: ""), completionHandle: {
                self.navigationController?.popViewController(animated: true)
            })
        }) { (error) in

        }
    }

    @objc fileprivate func eyeBtnClick(btn: UIButton) {
        let tag = btn.tag
        if tag == 100 {
            // 1.避免明文和密文切换后光标位置偏移
            previousPwdTextField?.isEnabled = false;
            if showPreviousPassword {
                btn.setImage(UIImage(named: "login_show_password"), for: .normal)
                previousPwdTextField?.isSecureTextEntry = true
            } else {
                btn.setImage(UIImage(named: "login_hide_password"), for: .normal)
                previousPwdTextField?.isSecureTextEntry = false
            }
            
            showPreviousPassword = !showPreviousPassword
            // 2.避免明文和密文切换后光标位置偏移
            previousPwdTextField?.isEnabled = true;
            previousPwdTextField?.becomeFirstResponder()

        } else if tag == 200 {
            // 1.避免明文和密文切换后光标位置偏移
            pwdTextField?.isEnabled = false;
            if showPassword {
                btn.setImage(UIImage(named: "login_show_password"), for: .normal)
                pwdTextField?.isSecureTextEntry = true
            } else {
                btn.setImage(UIImage(named: "login_hide_password"), for: .normal)
                pwdTextField?.isSecureTextEntry = false
            }

            showPassword = !showPassword
            // 2.避免明文和密文切换后光标位置偏移
            pwdTextField?.isEnabled = true;
            pwdTextField?.becomeFirstResponder()

        } else if tag == 300 {
            // 1.避免明文和密文切换后光标位置偏移
            repeatPwdTextField?.isEnabled = false;
            if showRepeatPassword {
                btn.setImage(UIImage(named: "login_show_password"), for: .normal)
                repeatPwdTextField?.isSecureTextEntry = true
            } else {
                btn.setImage(UIImage(named: "login_hide_password"), for: .normal)
                repeatPwdTextField?.isSecureTextEntry = false
            }

            showRepeatPassword = !showRepeatPassword
            // 2.避免明文和密文切换后光标位置偏移
            repeatPwdTextField?.isEnabled = true;
            repeatPwdTextField?.becomeFirstResponder()
        }
    }

    fileprivate func rightView(tag: Int) -> UIView {
        let btn = UIButton(image: UIImage(named: "login_show_password"), highlightedImage: UIImage(named: "login_show_password"), target: self, selector: #selector(eyeBtnClick))
        btn.tag = tag
        btn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        rightView.addSubview(btn)

        return rightView
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = NSLocalizedString("修改登录密码", comment: "")

        let previousPwdRightView = rightView(tag: 100)
        previousPwdTextField = CommonTextField(text: nil, placeholder: NSLocalizedString("请输入旧登录密码", comment: ""), rightView: previousPwdRightView, rightViewMode: .always)
        previousPwdTextField?.delegate = self
        previousPwdTextField?.isSecureTextEntry = true
        self.view.addSubview(previousPwdTextField!)
        previousPwdTextField!.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }

        let pwdRightView = rightView(tag: 200)
        pwdTextField = CommonTextField(text: nil, placeholder: NSLocalizedString("请输入6-16位字符和数字的登录密码", comment: ""), rightView: pwdRightView, rightViewMode: .always)
        pwdTextField?.delegate = self
        pwdTextField?.isSecureTextEntry = true
        self.view.addSubview(pwdTextField!)
        pwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(previousPwdTextField!.snp.bottom).offset(15)
            make.left.right.equalTo(self.view)
            make.height.equalTo(previousPwdTextField!)
        }

        let pepeatPwdRightView = rightView(tag: 300)
        repeatPwdTextField = CommonTextField(text: nil, placeholder: NSLocalizedString("请再次输入新密码", comment: ""), rightView: pepeatPwdRightView, rightViewMode: .always)
        repeatPwdTextField?.delegate = self
        repeatPwdTextField?.isSecureTextEntry = true
        self.view.addSubview(repeatPwdTextField!)
        repeatPwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(pwdTextField!.snp.bottom).offset(15)
            make.left.right.height.equalTo(pwdTextField!)
        }

        let confirmBtn = CommonButton(title: NSLocalizedString("确定修改密码", comment: ""), target: self, selector: #selector(resetPasswordBtnClick))
        self.view.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50);
            make.left.equalTo(self.view).offset(30);
            make.right.equalTo(self.view).offset(-30);
            make.top.equalTo(repeatPwdTextField!.snp.bottom).offset(60);
        }
    }
}
